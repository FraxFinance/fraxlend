## FraxlendPairDeployer

Deploys and initializes new FraxlendPairs

_Uses create2 to deploy the pairs, logs an event, and records a list of all deployed pairs_

## LogDeploy

```solidity
event LogDeploy(string _name, address _address, address _asset, address _collateral, address _oracleMultiply, address _oracleDivide, address _rateContract, uint256 _maxLTV, uint256 _liquidationFee, uint256 _maturityDate)
```

Emits when a new pair is deployed
The ```LogDeploy``` event is emitted when a new Pair is deployed

| Param | Type | Description |
| ---- | ---- | ----------- |
| _name | string | The name of the Pair |
| _address | address | The address of the pair |
| _asset | address | The address of the Asset Token contract |
| _collateral | address | The address of the Collateral Token contract |
| _oracleMultiply | address | The address of the numerator price Oracle |
| _oracleDivide | address | The address of the denominator price Oracle |
| _rateContract | address | The address of the Rate Calculator contract |
| _maxLTV | uint256 | The Maximum Loan-To-Value for a borrower to be considered solvent (1e5 precision) |
| _liquidationFee | uint256 | The fee paid to liquidators given as a % of the repayment (1e5 precision) |
| _maturityDate | uint256 | The maturityDate of the Pair |

## deployedPairsLength

```solidity
function deployedPairsLength() external view returns (uint256)
```

The ```deployedPairsLength``` function returns the length of the deployedPairsArray

| Return | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | length of array |

## getAllPairAddresses

```solidity
function getAllPairAddresses() external view returns (address[])
```

The ```getAllPairAddresses``` function returns all pair addresses in deployedPairsArray

| Return | Type | Description |
| ---- | ---- | ----------- |
| [0] | address[] | memory All deployed pair addresses |

## getCustomStatuses

```solidity
function getCustomStatuses(address[] _addresses) external view returns (struct FraxlendPairDeployer.PairCustomStatus[] _pairCustomStatuses)
```

The ```getCustomStatuses``` function returns an array of structs which contain the address and custom status

| Param | Type | Description |
| ---- | ---- | ----------- |
| _addresses | address[] | Addresses to check for custom status |

| Return | Type | Description |
| ---- | ---- | ----------- |
| _pairCustomStatuses | struct FraxlendPairDeployer.PairCustomStatus[] | memory Array of structs containing information |

## setCreationCode

```solidity
function setCreationCode(bytes _creationCode) external
```

The ```setCreationCode``` function sets the bytecode for the fraxlendPair

_splits the data if necessary to accomodate creation code that is slightly larger than 24kb_

| Param | Type | Description |
| ---- | ---- | ----------- |
| _creationCode | bytes | The creationCode for the Fraxlend Pair |

## _deployFirst

```solidity
function _deployFirst(bytes32 _saltSeed, bytes _configData, bytes _immutables, uint256 _maxLTV, uint256 _liquidationFee, uint256 _maturityDate, uint256 _penaltyRate, bool _isBorrowerWhitelistActive, bool _isLenderWhitelistActive) private returns (address _pairAddress)
```

The ```_deployFirst``` function is an internal function with deploys the pair

| Param | Type | Description |
| ---- | ---- | ----------- |
| _saltSeed | bytes32 |  |
| _configData | bytes | abi.encode(address _asset, address _collateral, address _oracleMultiply, address _oracleDivide, uint256 _oracleNormalization, address _rateContract, bytes memory _rateInitData) |
| _immutables | bytes |  |
| _maxLTV | uint256 | The Maximum Loan-To-Value for a borrower to be considered solvent (1e5 precision) |
| _liquidationFee | uint256 | The fee paid to liquidators given as a % of the repayment (1e5 precision) |
| _maturityDate | uint256 | The maturityDate of the Pair |
| _penaltyRate | uint256 |  |
| _isBorrowerWhitelistActive | bool | Enables borrower whitelist |
| _isLenderWhitelistActive | bool | Enables lender whitelist |

| Return | Type | Description |
| ---- | ---- | ----------- |
| _pairAddress | address | The address to which the Pair was deployed |

## _deploySecond

```solidity
function _deploySecond(string _name, address _pairAddress, bytes _configData, address[] _approvedBorrowers, address[] _approvedLenders) private
```

The ```_deploySecond``` function is the second part of deployment, it invoked the initialize() on the Pair

| Param | Type | Description |
| ---- | ---- | ----------- |
| _name | string | The name of the Pair |
| _pairAddress | address | The address of the Pair |
| _configData | bytes | abi.encode(address _asset, address _collateral, address _oracleMultiply, address _oracleDivide, uint256 _oracleNormalization, address _rateContract, bytes memory _rateInitData) |
| _approvedBorrowers | address[] | An array of approved borrower addresses |
| _approvedLenders | address[] | An array of approved lender addresses |

## _logDeploy

```solidity
function _logDeploy(string _name, address _pairAddress, bytes _configData, uint256 _maxLTV, uint256 _liquidationFee, uint256 _maturityDate) private
```

The ```_logDeploy``` function emits a LogDeploy event

| Param | Type | Description |
| ---- | ---- | ----------- |
| _name | string | The name of the Pair |
| _pairAddress | address | The address of the Pair |
| _configData | bytes | abi.encode(address _asset, address _collateral, address _oracleMultiply, address _oracleDivide, uint256 _oracleNormalization, address _rateContract, bytes memory _rateInitData) |
| _maxLTV | uint256 | The Maximum Loan-To-Value for a borrower to be considered solvent (1e5 precision) |
| _liquidationFee | uint256 | The fee paid to liquidators given as a % of the repayment (1e5 precision) |
| _maturityDate | uint256 | The maturityDate of the Pair |

## deploy

```solidity
function deploy(bytes _configData) external returns (address _pairAddress)
```

The ```deploy``` function allows anyone to create a custom lending market between an Asset and Collateral Token

| Param | Type | Description |
| ---- | ---- | ----------- |
| _configData | bytes | abi.encode(address _asset, address _collateral, address _oracleMultiply, address _oracleDivide, uint256 _oracleNormalization, address _rateContract, bytes memory _rateInitData) |

| Return | Type | Description |
| ---- | ---- | ----------- |
| _pairAddress | address | The address to which the Pair was deployed |

## deployCustom

```solidity
function deployCustom(string _name, bytes _configData, uint256 _maxLTV, uint256 _liquidationFee, uint256 _maturityDate, uint256 _penaltyRate, address[] _approvedBorrowers, address[] _approvedLenders) external returns (address _pairAddress)
```

The ```deployCustom``` function allows whitelisted users to deploy custom Term Sheets for OTC debt structuring

_Caller must be added to FraxLedWhitelist_

| Param | Type | Description |
| ---- | ---- | ----------- |
| _name | string | The name of the Pair |
| _configData | bytes | abi.encode(address _asset, address _collateral, address _oracleMultiply, address _oracleDivide, uint256 _oracleNormalization, address _rateContract, bytes memory _rateInitData) |
| _maxLTV | uint256 | The Maximum Loan-To-Value for a borrower to be considered solvent (1e5 precision) |
| _liquidationFee | uint256 | The fee paid to liquidators given as a % of the repayment (1e5 precision) |
| _maturityDate | uint256 | The maturityDate of the Pair |
| _penaltyRate | uint256 |  |
| _approvedBorrowers | address[] | An array of approved borrower addresses |
| _approvedLenders | address[] | An array of approved lender addresses |

| Return | Type | Description |
| ---- | ---- | ----------- |
| _pairAddress | address | The address to which the Pair was deployed |

## globalPause

```solidity
function globalPause(address[] _addresses) external returns (address[] _updatedAddresses)
```

The ```globalPause``` function calls the pause() function on a given set of pair addresses

_Ignores reverts when calling pause()_

| Param | Type | Description |
| ---- | ---- | ----------- |
| _addresses | address[] | Addresses to attempt to pause() |

| Return | Type | Description |
| ---- | ---- | ----------- |
| _updatedAddresses | address[] | Addresses for which pause() was successful |

