// SPDX-License-Identifier: ISC
pragma solidity ^0.8.12;

// ====================================================================
// |     ______                   _______                             |
// |    / _____________ __  __   / ____(_____  ____ _____  ________   |
// |   / /_  / ___/ __ `| |/_/  / /_  / / __ \/ __ `/ __ \/ ___/ _ \  |
// |  / __/ / /  / /_/ _>  <   / __/ / / / / / /_/ / / / / /__/  __/  |
// | /_/   /_/   \__,_/_/|_|  /_/   /_/_/ /_/\__,_/_/ /_/\___/\___/   |
// |                                                                  |
// ====================================================================
// ====================== FraxlendPairDeployer ========================
// ====================================================================
// Frax Finance: https://github.com/FraxFinance

// Primary Author
// Drake Evans: https://github.com/DrakeEvans

// Reviewers
// Dennis: https://github.com/denett
// Sam Kazemian: https://github.com/samkazemian
// Travis Moore: https://github.com/FortisFortuna
// Jack Corddry: https://github.com/corddry
// Rich Gee: https://github.com/zer0blockchain

// ====================================================================

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@rari-capital/solmate/src/utils/SSTORE2.sol";
import "./FraxlendPair.sol";
import "./interfaces/IRateCalculator.sol";
import "./interfaces/IFraxlendWhitelist.sol";
import "./libraries/SafeERC20.sol";

// solhint-disable no-inline-assembly

// debugging only
import "forge-std/Test.sol";

/// @title FraxlendPairDeployer
/// @author Drake Evans (Frax Finance) https://github.com/drakeevans
/// @notice Deploys and initializes new FraxlendPairs
/// @dev Uses create2 to deploy the pairs, logs an event, and records a list of all deployed pairs
contract FraxlendPairDeployer is Ownable {
    using SafeERC20 for IERC20;
    using Strings for uint256;

    // Constants
    uint256 private constant DEFAULT_MAX_LTV = 75000; // 75% with 1e5 precision
    uint256 private constant GLOBAL_MAX_LTV = 1e8; // 1000x (100,000%) with 1e5 precision, protects from rounding errors in LTV calc
    uint256 private constant DEFAULT_LIQ_FEE = 10000; // 10% with 1e5 precision

    address private contractAddress;

    // Admin contracts
    address private constant FRAXLEND_WHITELIST = address(1234); //TODO: update this

    /// @notice Emits when a new pair is deployed
    /// @notice The ```LogDeploy``` event is emitted when a new Pair is deployed
    /// @param _name The name of the Pair
    /// @param _address The address of the pair
    /// @param _asset The address of the Asset Token contract
    /// @param _collateral The address of the Collateral Token contract
    /// @param _oracleMultiply The address of the numerator price Oracle
    /// @param _oracleDivide The address of the denominator price Oracle
    /// @param _rateContract The address of the Rate Calculator contract
    /// @param _maxLTV The Maximum Loan-To-Value for a borrower to be considered solvent (1e5 precision)
    /// @param _liquidationFee The fee paid to liquidators given as a % of the repayment (1e5 precision)
    /// @param _maturity The maturity of the Pair
    event LogDeploy(
        string indexed _name,
        address _address,
        address indexed _asset,
        address indexed _collateral,
        address _oracleMultiply,
        address _oracleDivide,
        address _rateContract,
        uint256 _maxLTV,
        uint256 _liquidationFee,
        uint256 _maturity
    );

    /// @notice CREATE2 salt => deployed address
    mapping(bytes32 => address) public deployedPairsBySalt;
    /// @notice hash of name => deployed address
    mapping(string => address) public deployedPairsByName;
    /// @notice List of the names of all deployed Pairs
    string[] public deployedPairsArray;

    constructor() Ownable() {}

    function setCreationCode(bytes memory _creationCode) external onlyOwner {
        contractAddress = SSTORE2.write(_creationCode);
    }

    /// @notice The ```deploy``` function allows anyone to create a custom lending market between an Asset and Collateral Token
    /// @param _configData abi.encode(address _asset, address _collateral, address _oracleMultiply, address _oracleMivide, uint256 _oracleNormalization, address _rateContract, bytes memory _rateInitData)
    /// @return _pairAddress The address to which the Pair was deployed
    function deploy(bytes memory _configData) external returns (address _pairAddress) {
        (address _asset, address _collateral, , , , address _rateContract, ) = abi.decode(
            _configData,
            (address, address, address, address, uint256, address, bytes)
        );
        string memory _name = string(
            abi.encodePacked(
                "FraxlendV1-",
                IERC20(_collateral).safeName(),
                "/",
                IERC20(_asset).safeName(),
                " - ",
                IRateCalculator(_rateContract).name(),
                " - ",
                (deployedPairsArray.length + 1).toString()
            )
        );

        _pairAddress = _deployFirst(
            keccak256(abi.encodePacked("public")),
            _configData,
            DEFAULT_MAX_LTV,
            DEFAULT_LIQ_FEE,
            0,
            0,
            false,
            false
        );

        _deploySecond(_name, _pairAddress, _configData, new address[](0), new address[](0));

        _logDeploy(_name, _pairAddress, _configData, DEFAULT_MAX_LTV, DEFAULT_LIQ_FEE, 0);
    }

    /// @notice The ```deployCustom``` function allows whitelisted users to deploy custom Term Sheets for OTC debt structuring
    /// @dev Caller must be added to FraxLedWhitelist
    /// @param _name The name of the Pair
    /// @param _configData abi.encode(address _asset, address _collateral, address _oracleMultiply, address _oracleMivide, uint256 _oracleNormalization, address _rateContract, bytes memory _rateInitData)
    /// @param _maxLTV The Maximum Loan-To-Value for a borrower to be considered solvent (1e5 precision)
    /// @param _liquidationFee The fee paid to liquidators given as a % of the repayment (1e5 precision)
    /// @param _maturity The maturity of the Pair
    /// @param _approvedBorrowers An array of approved borrower addresses
    /// @param _approvedLenders An array of approved lender addresses
    /// @return _pairAddress The address to which the Pair was deployed
    function deployCustom(
        string memory _name,
        bytes memory _configData,
        uint256 _maxLTV,
        uint256 _liquidationFee,
        uint256 _maturity,
        uint256 _penaltyRate,
        address[] memory _approvedBorrowers,
        address[] memory _approvedLenders
    ) external returns (address _pairAddress) {
        require(_maxLTV <= GLOBAL_MAX_LTV, "FraxlendPairDeployer: _maxLTV is too large");
        require(
            IFraxlendWhitelist(FRAXLEND_WHITELIST).fraxlendDeployerWhitelist(msg.sender),
            "FraxlendPairDeployer: Only whitelisted addresses"
        );

        _pairAddress = _deployFirst(
            keccak256(abi.encodePacked(_name)),
            _configData,
            _maxLTV,
            _liquidationFee,
            _maturity,
            _penaltyRate,
            _approvedBorrowers.length > 0,
            _approvedLenders.length > 0
        );

        _deploySecond(_name, _pairAddress, _configData, _approvedBorrowers, _approvedLenders);

        _logDeploy(_name, _pairAddress, _configData, _maxLTV, _liquidationFee, _maturity);
    }

    /// @notice The ```_deployFirst``` function is an internal function with deploys the pair
    /// @param _configData abi.encode(address _asset, address _collateral, address _oracleMultiply, address _oracleMivide, uint256 _oracleNormalization, address _rateContract, bytes memory _rateInitData)
    /// @param _maxLTV The Maximum Loan-To-Value for a borrower to be considered solvent (1e5 precision)
    /// @param _liquidationFee The fee paid to liquidators given as a % of the repayment (1e5 precision)
    /// @param _maturity The maturity of the Pair
    /// @param _isBorrowerWhitelistActive Enables borrower whitelist
    /// @param _isLenderWhitelistActive Enables lender whitelist
    /// @return _pairAddress The address to which the Pair was deployed
    function _deployFirst(
        bytes32 _saltSeed,
        bytes memory _configData,
        uint256 _maxLTV,
        uint256 _liquidationFee,
        uint256 _maturity,
        uint256 _penaltyRate,
        bool _isBorrowerWhitelistActive,
        bool _isLenderWhitelistActive
    ) private returns (address _pairAddress) {
        {
            // _saltSeed is the same for all public pairs so duplicates cannot be created
            bytes32 salt = keccak256(
                abi.encodePacked(_saltSeed, _configData, _isBorrowerWhitelistActive, _isLenderWhitelistActive)
            );
            require(deployedPairsBySalt[salt] == address(0), "FraxlendPairDeployer: Pair already deployed");
            bytes memory bytecode = abi.encodePacked(
                SSTORE2.read(contractAddress),
                abi.encode(
                    _configData,
                    _maxLTV,
                    _liquidationFee,
                    _maturity,
                    _penaltyRate,
                    _isBorrowerWhitelistActive,
                    _isLenderWhitelistActive
                )
            );

            assembly {
                _pairAddress := create2(0, add(bytecode, 32), mload(bytecode), salt)
            }
            require(_pairAddress != address(0), "FraxlendPairDeployer: create2 failed");

            deployedPairsBySalt[salt] = _pairAddress;
        }

        return _pairAddress;
    }

    /// @notice The ```_deploySecond``` function is the second part of deployment, it invoked the initialize() on the Pair
    /// @param _name The name of the Pair
    /// @param _pairAddress The address of the Pair
    /// @param _configData abi.encode(address _asset, address _collateral, address _oracleMultiply, address _oracleMivide, uint256 _oracleNormalization, address _rateContract, bytes memory _rateInitData)
    /// @param _approvedBorrowers An array of approved borrower addresses
    /// @param _approvedLenders An array of approved lender addresses
    function _deploySecond(
        string memory _name,
        address _pairAddress,
        bytes memory _configData,
        address[] memory _approvedBorrowers,
        address[] memory _approvedLenders
    ) private {
        (, , , , , , bytes memory _rateInitData) = abi.decode(
            _configData,
            (address, address, address, address, uint256, address, bytes)
        );
        require(deployedPairsByName[_name] == address(0), "FraxlendPairDeployer: Pair name must be unique");
        deployedPairsByName[_name] = _pairAddress;
        deployedPairsArray.push(_name);

        // Set additional values for FraxlendPair
        FraxlendPair(_pairAddress).initialize(_name, _approvedBorrowers, _approvedLenders, _rateInitData);
    }

    function _logDeploy(
        string memory _name,
        address _pairAddress,
        bytes memory _configData,
        uint256 _maxLTV,
        uint256 _liquidationFee,
        uint256 _maturity
    ) private {
        (
            address _asset,
            address _collateral,
            address _oracleMultiply,
            address _oracleDivide,
            ,
            address _rateContract,

        ) = abi.decode(_configData, (address, address, address, address, uint256, address, bytes));
        emit LogDeploy(
            _name,
            _pairAddress,
            _asset,
            _collateral,
            _oracleMultiply,
            _oracleDivide,
            _rateContract,
            _maxLTV,
            _liquidationFee,
            _maturity
        );
    }
}
