

## name

```solidity
function name() external pure returns (string)
```

The ```name``` function returns the name of the rate contract

| Return | Type | Description |
| ---- | ---- | ----------- |
| [0] | string | memory name of contract |

## getConstants

```solidity
function getConstants() external pure returns (bytes _calldata)
```

The ```getConstants``` function returns abi encoded constants

| Return | Type | Description |
| ---- | ---- | ----------- |
| _calldata | bytes | abi.encode(uint256 MIN_INT, uint256 MAX_INT, uint256 MAX_VERTEX_UTIL, uint256 UTIL_PREC) |

## requireValidInitData

```solidity
function requireValidInitData(bytes _initData) public pure
```

The ```requireValidInitData``` function reverts if initialization data fails to be validated

| Param | Type | Description |
| ---- | ---- | ----------- |
| _initData | bytes | abi.encode(uint256 _minInterest, uint256 _vertexInterest, uint256 _maxInterest, uint256 _vertexUtilization) |

## getNewRate

```solidity
function getNewRate(bytes _data, bytes _initData) external pure returns (uint64 _newRatePerSec)
```

Calculates interest rates using two linear functions f(utilization)

_We use calldata to remain unopinionated about future implementations_

| Param | Type | Description |
| ---- | ---- | ----------- |
| _data | bytes | abi.encode(uint64 _currentRatePerSec, uint256 _deltaTime, uint256 _utilization, uint256 _deltaBlocks) |
| _initData | bytes | abi.encode(uint256 _minInterest, uint256 _vertexInterest, uint256 _maxInterest, uint256 _vertexUtilization) |

| Return | Type | Description |
| ---- | ---- | ----------- |
| _newRatePerSec | uint64 | The new interest rate per second, 1e18 precision |

