// SPDX-License-Identifier: ISC
pragma solidity >=0.8.13;

interface IFraxlendPair {
    function addCollateral(uint256 _collateralAmount, address _borrower) external;

    function addInterest() external returns (uint256 _interestEarned);

    function allowance(address owner, address spender) external view returns (uint256);

    function approve(address spender, uint256 amount) external returns (bool);

    function approvedBorrowers(address) external view returns (bool);

    function approvedLenders(address) external view returns (bool);

    function asset() external view returns (address);

    function assetsOf(address _depositor) external view returns (uint256 _assets);

    function assetsPerShare() external view returns (uint256 _assetsPerUnitShare);

    function balanceOf(address account) external view returns (uint256);

    function borrowAsset(
        uint256 _borrowAmount,
        uint256 _collateralAmount,
        address _receiver
    ) external returns (uint256 _shares);

    function borrowerWhitelistActive() external view returns (bool);

    function changeFee(uint16 _newFee) external;

    function collateralContract() external view returns (address);

    function convertToAssets(uint256 _shares) external view returns (uint256);

    function convertToShares(uint256 _amount) external view returns (uint256);

    function currentRateInfo()
        external
        view
        returns (
            uint16 lastBlock,
            uint16 feeToProtocolRate,
            uint32 lastTimestamp,
            uint64 ratePerSec
        );

    function decimals() external pure returns (uint8);

    function decreaseAllowance(address spender, uint256 subtractedValue) external returns (bool);

    function deployerContract() external view returns (address);

    function deposit(uint256 _amount, address _receiver) external returns (uint256 _sharesReceived);

    function exchangeRateInfo() external view returns (uint32 lastTimestamp, uint224 exchangeRate);

    function increaseAllowance(address spender, uint256 addedValue) external returns (bool);

    function initialize(
        string calldata _name,
        address[] calldata _approvedBorrowers,
        address[] calldata _approvedLenders,
        bytes calldata _rateInitCallData
    ) external;

    function initializeFirst(
        bytes calldata _configData,
        uint256 _maxLTV,
        uint256 _liquidationFee,
        uint256 _maturity,
        uint256 _penaltyRate,
        bool _isBorrowerWhitelistActive,
        bool _isLenderWhitelistActive
    ) external;

    function lenderWhitelistActive() external view returns (bool);

    function leveragedPosition(
        address _swapperAddress,
        uint256 _borrowAmount,
        uint256 _initialCollateralAmount,
        uint256 _amountCollateralOutMin,
        address[] calldata _path
    ) external returns (uint256 _totalCollateralBalance);

    function liquidate(uint256 _shares, address _borrower) external returns (uint256 _collateralForLiquidator);

    function liquidationFee() external view returns (uint256);

    function maturity() external view returns (uint256);

    function maxDeposit(address) external pure returns (uint256);

    function maxLTV() external view returns (uint256);

    function maxMint(address) external pure returns (uint256);

    function maxRedeem(address owner) external view returns (uint256);

    function maxWithdraw(address owner) external view returns (uint256);

    function mint(uint256 _shares, address _receiver) external returns (uint256 _amountReceived);

    function name() external view returns (string calldata);

    function oracleDivide() external view returns (address);

    function oracleMultiply() external view returns (address);

    function oracleNormalization() external view returns (uint256);

    function owner() external view returns (address);

    function pause() external;

    function paused() external view returns (bool);

    function penaltyRate() external view returns (uint256);

    function previewDeposit(uint256 _amount) external view returns (uint256);

    function previewMint(uint256 _shares) external view returns (uint256);

    function previewRedeem(uint256 _shares) external view returns (uint256);

    function previewWithdraw(uint256 _amount) external view returns (uint256);

    function rateContract() external view returns (address);

    function rateInitCallData() external view returns (bytes calldata);

    function redeem(
        uint256 _shares,
        address _receiver,
        address _owner
    ) external returns (uint256 _amountToReturn);

    function removeCollateral(uint256 _collateralAmount, address _receiver) external;

    function renounceOwnership() external;

    function repayAsset(uint256 _shares, address _borrower) external returns (uint256 _amountToRepay);

    function repayAssetWithCollateral(
        address _swapperAddress,
        uint256 _collateralToSwap,
        uint256 _amountAssetOutMin,
        address[] calldata _path
    ) external returns (uint256 _amountAssetOut);

    function setApprovedBorrowers(address[] calldata _borrowers, bool _approval) external;

    function setApprovedLenders(address[] calldata _lenders, bool _approval) external;

    function setSwapper(address _swapper, bool _approval) external;

    function swappers(address) external view returns (bool);

    function symbol() external view returns (string calldata);

    function totalAsset() external view returns (uint128 amount, uint128 shares);

    function totalAssets() external view returns (uint256);

    function totalBorrow() external view returns (uint128 amount, uint128 shares);

    function totalCollateral() external view returns (uint256);

    function totalSupply() external view returns (uint256);

    function transfer(address to, uint256 amount) external returns (bool);

    function transferFrom(
        address from,
        address to,
        uint256 amount
    ) external returns (bool);

    function transferOwnership(address newOwner) external;

    function unpause() external;

    function updateExchangeRate() external returns (uint256 _exchangeRate);

    function userBorrowShares(address) external view returns (uint256);

    function userCollateralBalance(address) external view returns (uint256);

    function withdraw(
        uint256 _amount,
        address _receiver,
        address _owner
    ) external returns (uint256 _shares);

    function withdrawFees(uint128 _shares, address _recipient) external returns (uint256 _amountToTransfer);
}
