## VariableInterestRate

A Contract for calulcating interest rates as a function of utilization and time

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
| _calldata | bytes | abi.encode(uint32 MIN_UTIL, uint32 MAX_UTIL, uint32 UTIL_PREC, uint64 MIN_INT, uint64 MAX_INT, uint256 INT_HALF_LIFE) |

## requireValidInitData

```solidity
function requireValidInitData(bytes _initData) external pure
```

The ```requireValidInitData``` function No-op as this contract has no init data

## getNewRate

```solidity
function getNewRate(bytes _data, bytes _initData) external pure returns (uint64 _newRatePerSec)
```

The ```getNewRate``` function calculates the new interest rate as a function of time and utilization

| Param | Type | Description |
| ---- | ---- | ----------- |
| _data | bytes | abi.encode(uint64 _currentRatePerSec, uint256 _deltaTime, uint256 _utilization, uint256 _deltaBlocks) |
| _initData | bytes | empty for this Rate Calculator |

| Return | Type | Description |
| ---- | ---- | ----------- |
| _newRatePerSec | uint64 | The new interest rate per second, 1e18 precision |

