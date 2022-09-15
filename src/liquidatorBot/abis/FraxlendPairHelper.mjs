export const fraxlendPairHelperAbi = [
  { "inputs": [{ "internalType": "address", "name": "_oracle", "type": "address" }], "name": "OracleLTEZero", "type": "error" },
  {
    "inputs": [{ "internalType": "address", "name": "_fraxlendPairAddress", "type": "address" }],
    "name": "getImmutableAddressBool",
    "outputs": [
      {
        "components": [
          { "internalType": "bool", "name": "_borrowerWhitelistActive", "type": "bool" },
          { "internalType": "bool", "name": "_lenderWhitelistActive", "type": "bool" },
          { "internalType": "address", "name": "_assetContract", "type": "address" },
          { "internalType": "address", "name": "_collateralContract", "type": "address" },
          { "internalType": "address", "name": "_oracleMultiply", "type": "address" },
          { "internalType": "address", "name": "_oracleDivide", "type": "address" },
          { "internalType": "address", "name": "_rateContract", "type": "address" },
          { "internalType": "address", "name": "_DEPLOYER_CONTRACT", "type": "address" },
          { "internalType": "address", "name": "_COMPTROLLER_ADDRESS", "type": "address" },
          { "internalType": "address", "name": "_FRAXLEND_WHITELIST", "type": "address" }
        ],
        "internalType": "struct FraxlendPairHelper.ImmutablesAddressBool",
        "name": "",
        "type": "tuple"
      }
    ],
    "stateMutability": "view",
    "type": "function"
  },
  {
    "inputs": [{ "internalType": "address", "name": "_fraxlendPairAddress", "type": "address" }],
    "name": "getImmutableUint256",
    "outputs": [
      {
        "components": [
          { "internalType": "uint256", "name": "_oracleNormalization", "type": "uint256" },
          { "internalType": "uint256", "name": "_maxLTV", "type": "uint256" },
          { "internalType": "uint256", "name": "_liquidationFee", "type": "uint256" },
          { "internalType": "uint256", "name": "_maturityDate", "type": "uint256" },
          { "internalType": "uint256", "name": "_penaltyRate", "type": "uint256" }
        ],
        "internalType": "struct FraxlendPairHelper.ImmutablesUint256",
        "name": "",
        "type": "tuple"
      }
    ],
    "stateMutability": "view",
    "type": "function"
  },
  {
    "inputs": [{ "internalType": "address", "name": "_fraxlendPairAddress", "type": "address" }],
    "name": "getPairAccounting",
    "outputs": [
      { "internalType": "uint128", "name": "_totalAssetAmount", "type": "uint128" },
      { "internalType": "uint128", "name": "_totalAssetShares", "type": "uint128" },
      { "internalType": "uint128", "name": "_totalBorrowAmount", "type": "uint128" },
      { "internalType": "uint128", "name": "_totalBorrowShares", "type": "uint128" },
      { "internalType": "uint256", "name": "_totalCollateral", "type": "uint256" }
    ],
    "stateMutability": "view",
    "type": "function"
  },
  {
    "inputs": [
      { "internalType": "address", "name": "_fraxlendPairAddress", "type": "address" },
      { "internalType": "address", "name": "_address", "type": "address" }
    ],
    "name": "getUserSnapshot",
    "outputs": [
      { "internalType": "uint256", "name": "_userAssetShares", "type": "uint256" },
      { "internalType": "uint256", "name": "_userBorrowShares", "type": "uint256" },
      { "internalType": "uint256", "name": "_userCollateralBalance", "type": "uint256" }
    ],
    "stateMutability": "view",
    "type": "function"
  },
  {
    "inputs": [
      { "internalType": "address", "name": "_fraxlendPairAddress", "type": "address" },
      { "internalType": "uint128", "name": "_sharesToLiquidate", "type": "uint128" },
      { "internalType": "address", "name": "_borrower", "type": "address" }
    ],
    "name": "previewLiquidatePure",
    "outputs": [
      { "internalType": "uint128", "name": "_amountLiquidatorToRepay", "type": "uint128" },
      { "internalType": "uint256", "name": "_collateralForLiquidator", "type": "uint256" },
      { "internalType": "uint128", "name": "_sharesToSocialize", "type": "uint128" },
      { "internalType": "uint128", "name": "_amountToSocialize", "type": "uint128" }
    ],
    "stateMutability": "view",
    "type": "function"
  },
  {
    "inputs": [
      { "internalType": "address", "name": "_fraxlendPairAddress", "type": "address" },
      { "internalType": "uint256", "name": "_timestamp", "type": "uint256" },
      { "internalType": "uint256", "name": "_blockNumber", "type": "uint256" }
    ],
    "name": "previewRateInterest",
    "outputs": [
      { "internalType": "uint256", "name": "_interestEarned", "type": "uint256" },
      { "internalType": "uint256", "name": "_newRate", "type": "uint256" }
    ],
    "stateMutability": "view",
    "type": "function"
  },
  {
    "inputs": [
      { "internalType": "address", "name": "_fraxlendPairAddress", "type": "address" },
      { "internalType": "uint256", "name": "_timestamp", "type": "uint256" },
      { "internalType": "uint256", "name": "_blockNumber", "type": "uint256" }
    ],
    "name": "previewRateInterestFees",
    "outputs": [
      { "internalType": "uint256", "name": "_interestEarned", "type": "uint256" },
      { "internalType": "uint256", "name": "_feesAmount", "type": "uint256" },
      { "internalType": "uint256", "name": "_feesShare", "type": "uint256" },
      { "internalType": "uint256", "name": "_newRate", "type": "uint256" }
    ],
    "stateMutability": "view",
    "type": "function"
  },
  {
    "inputs": [{ "internalType": "address", "name": "_fraxlendPairAddress", "type": "address" }],
    "name": "previewUpdateExchangeRate",
    "outputs": [{ "internalType": "uint256", "name": "_exchangeRate", "type": "uint256" }],
    "stateMutability": "view",
    "type": "function"
  }
]
