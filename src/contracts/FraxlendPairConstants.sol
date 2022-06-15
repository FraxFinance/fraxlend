// SPDX-License-Identifier: ISC
pragma solidity ^0.8.13;

// ====================================================================
// |     ______                   _______                             |
// |    / _____________ __  __   / ____(_____  ____ _____  ________   |
// |   / /_  / ___/ __ `| |/_/  / /_  / / __ \/ __ `/ __ \/ ___/ _ \  |
// |  / __/ / /  / /_/ _>  <   / __/ / / / / / /_/ / / / / /__/  __/  |
// | /_/   /_/   \__,_/_/|_|  /_/   /_/_/ /_/\__,_/_/ /_/\___/\___/   |
// |                                                                  |
// ====================================================================
// ===================== FraxlendPairConstants ========================
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

abstract contract FraxlendPairConstants {
    // ============================================================================================
    // Constants
    // ============================================================================================

    // Precision settings
    uint256 internal constant LTV_PRECISION = 1e5; // 5 decimals
    uint256 internal constant LIQ_PRECISION = 1e5;
    uint256 internal constant UTIL_PREC = 1e5;
    uint256 internal constant FEE_PRECISION = 1e5;
    uint256 internal constant EXCHANGE_PRECISION = 1e18;

    // Default Interest Rate (if borrows = 0)
    uint64 internal constant DEFAULT_INT = 158247046; // 0.5% annual rate

    // Admin contracts
    address internal constant TIME_LOCK_ADDRESS = 0x8412ebf45bAC1B340BbE8F318b928C466c4E39CA;
    address internal constant COMPTROLLER_ADDRESS = 0x8D8Cb63BcB8AD89Aa750B9f80Aa8Fa4CfBcC8E0C;

    // Dependencies
    address internal constant FRAXLEND_WHITELIST = address(1234); // TODO: update this
    address internal constant FRAXSWAP_ROUTER = 0xE52D0337904D4D0519EF7487e707268E1DB6495F;

    // Protocol Fee
    uint16 internal constant DEFAULT_PROTOCOL_FEE = 0;
    uint256 internal constant MAX_PROTOCOL_FEE = 5e4; // 50%

    error Insolvent(uint256 _borrow, uint256 _collateral, uint256 _exchangeRate);
    error BorrowerSolvent();
    error OnlyApprovedBorrowers();
    error OnlyApprovedLenders();
    error PastMaturity();
    error ProtocolOrOwnerOnly();
    error OracleLTEZero(address _oracle);
    error InsufficientAssetsInContract(uint256 _assets, uint256 _request);
    error NotOnWhitelist(address _address);
    error NotDeployer();
    error NameEmpty();
    error AlreadyInitialized();
    error SlippageTooHigh(uint256 _minOut, uint256 _actual);
    error BadSwapper();
    error InvalidPath(address _expected, address _actual);
    error BadProtocolFee();
    error ViolateMaxMintDeposit();
    error BorrowerWhitelistRequired();
}
