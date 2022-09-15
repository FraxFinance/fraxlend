export const fraxlendPairDeployerAbi = [
  {
    "inputs": [
      { "internalType": "address", "name": "_circuitBreaker", "type": "address" },
      { "internalType": "address", "name": "_comptroller", "type": "address" },
      { "internalType": "address", "name": "_timelock", "type": "address" },
      { "internalType": "address", "name": "_fraxlendWhitelist", "type": "address" }
    ],
    "stateMutability": "nonpayable",
    "type": "constructor"
  },
  {
    "anonymous": false,
    "inputs": [
      { "indexed": true, "internalType": "string", "name": "_name", "type": "string" },
      { "indexed": false, "internalType": "address", "name": "_address", "type": "address" },
      { "indexed": true, "internalType": "address", "name": "_asset", "type": "address" },
      { "indexed": true, "internalType": "address", "name": "_collateral", "type": "address" },
      { "indexed": false, "internalType": "address", "name": "_oracleMultiply", "type": "address" },
      { "indexed": false, "internalType": "address", "name": "_oracleDivide", "type": "address" },
      { "indexed": false, "internalType": "address", "name": "_rateContract", "type": "address" },
      { "indexed": false, "internalType": "uint256", "name": "_maxLTV", "type": "uint256" },
      { "indexed": false, "internalType": "uint256", "name": "_liquidationFee", "type": "uint256" },
      { "indexed": false, "internalType": "uint256", "name": "_maturityDate", "type": "uint256" }
    ],
    "name": "LogDeploy",
    "type": "event"
  },
  {
    "anonymous": false,
    "inputs": [
      { "indexed": true, "internalType": "address", "name": "previousOwner", "type": "address" },
      { "indexed": true, "internalType": "address", "name": "newOwner", "type": "address" }
    ],
    "name": "OwnershipTransferred",
    "type": "event"
  },
  {
    "inputs": [],
    "name": "CIRCUIT_BREAKER_ADDRESS",
    "outputs": [{ "internalType": "address", "name": "", "type": "address" }],
    "stateMutability": "view",
    "type": "function"
  },
  {
    "inputs": [],
    "name": "COMPTROLLER_ADDRESS",
    "outputs": [{ "internalType": "address", "name": "", "type": "address" }],
    "stateMutability": "view",
    "type": "function"
  },
  {
    "inputs": [],
    "name": "DEFAULT_LIQ_FEE",
    "outputs": [{ "internalType": "uint256", "name": "", "type": "uint256" }],
    "stateMutability": "view",
    "type": "function"
  },
  {
    "inputs": [],
    "name": "DEFAULT_MAX_LTV",
    "outputs": [{ "internalType": "uint256", "name": "", "type": "uint256" }],
    "stateMutability": "view",
    "type": "function"
  },
  {
    "inputs": [],
    "name": "GLOBAL_MAX_LTV",
    "outputs": [{ "internalType": "uint256", "name": "", "type": "uint256" }],
    "stateMutability": "view",
    "type": "function"
  },
  {
    "inputs": [],
    "name": "TIME_LOCK_ADDRESS",
    "outputs": [{ "internalType": "address", "name": "", "type": "address" }],
    "stateMutability": "view",
    "type": "function"
  },
  {
    "inputs": [{ "internalType": "bytes", "name": "_configData", "type": "bytes" }],
    "name": "deploy",
    "outputs": [{ "internalType": "address", "name": "_pairAddress", "type": "address" }],
    "stateMutability": "nonpayable",
    "type": "function"
  },
  {
    "inputs": [
      { "internalType": "string", "name": "_name", "type": "string" },
      { "internalType": "bytes", "name": "_configData", "type": "bytes" },
      { "internalType": "uint256", "name": "_maxLTV", "type": "uint256" },
      { "internalType": "uint256", "name": "_liquidationFee", "type": "uint256" },
      { "internalType": "uint256", "name": "_maturityDate", "type": "uint256" },
      { "internalType": "uint256", "name": "_penaltyRate", "type": "uint256" },
      { "internalType": "address[]", "name": "_approvedBorrowers", "type": "address[]" },
      { "internalType": "address[]", "name": "_approvedLenders", "type": "address[]" }
    ],
    "name": "deployCustom",
    "outputs": [{ "internalType": "address", "name": "_pairAddress", "type": "address" }],
    "stateMutability": "nonpayable",
    "type": "function"
  },
  {
    "inputs": [{ "internalType": "address", "name": "", "type": "address" }],
    "name": "deployedPairCustomStatusByAddress",
    "outputs": [{ "internalType": "bool", "name": "", "type": "bool" }],
    "stateMutability": "view",
    "type": "function"
  },
  {
    "inputs": [{ "internalType": "uint256", "name": "", "type": "uint256" }],
    "name": "deployedPairsArray",
    "outputs": [{ "internalType": "string", "name": "", "type": "string" }],
    "stateMutability": "view",
    "type": "function"
  },
  {
    "inputs": [{ "internalType": "string", "name": "", "type": "string" }],
    "name": "deployedPairsByName",
    "outputs": [{ "internalType": "address", "name": "", "type": "address" }],
    "stateMutability": "view",
    "type": "function"
  },
  {
    "inputs": [{ "internalType": "bytes32", "name": "", "type": "bytes32" }],
    "name": "deployedPairsBySalt",
    "outputs": [{ "internalType": "address", "name": "", "type": "address" }],
    "stateMutability": "view",
    "type": "function"
  },
  {
    "inputs": [],
    "name": "deployedPairsLength",
    "outputs": [{ "internalType": "uint256", "name": "", "type": "uint256" }],
    "stateMutability": "view",
    "type": "function"
  },
  {
    "inputs": [],
    "name": "getAllPairAddresses",
    "outputs": [{ "internalType": "address[]", "name": "", "type": "address[]" }],
    "stateMutability": "view",
    "type": "function"
  },
  {
    "inputs": [{ "internalType": "address[]", "name": "_addresses", "type": "address[]" }],
    "name": "getCustomStatuses",
    "outputs": [
      {
        "components": [
          { "internalType": "address", "name": "_address", "type": "address" },
          { "internalType": "bool", "name": "_isCustom", "type": "bool" }
        ],
        "internalType": "struct FraxlendPairDeployer.PairCustomStatus[]",
        "name": "_pairCustomStatuses",
        "type": "tuple[]"
      }
    ],
    "stateMutability": "view",
    "type": "function"
  },
  {
    "inputs": [{ "internalType": "address[]", "name": "_addresses", "type": "address[]" }],
    "name": "globalPause",
    "outputs": [{ "internalType": "address[]", "name": "_updatedAddresses", "type": "address[]" }],
    "stateMutability": "nonpayable",
    "type": "function"
  },
  {
    "inputs": [],
    "name": "owner",
    "outputs": [{ "internalType": "address", "name": "", "type": "address" }],
    "stateMutability": "view",
    "type": "function"
  },
  { "inputs": [], "name": "renounceOwnership", "outputs": [], "stateMutability": "nonpayable", "type": "function" },
  {
    "inputs": [{ "internalType": "bytes", "name": "_creationCode", "type": "bytes" }],
    "name": "setCreationCode",
    "outputs": [],
    "stateMutability": "nonpayable",
    "type": "function"
  },
  {
    "inputs": [{ "internalType": "address", "name": "newOwner", "type": "address" }],
    "name": "transferOwnership",
    "outputs": [],
    "stateMutability": "nonpayable",
    "type": "function"
  }
]
