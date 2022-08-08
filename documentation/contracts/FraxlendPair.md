

## toBorrowShares

```solidity
function toBorrowShares(uint256 _amount, bool _roundUp) external view returns (uint256)
```

The ```toBorrowShares``` function converts a given amount of borrow debt into the number of shares

| Param | Type | Description |
| ---- | ---- | ----------- |
| _amount | uint256 | Amount of borrow |
| _roundUp | bool | Whether to roundup during division |

## toBorrowAmount

```solidity
function toBorrowAmount(uint256 _shares, bool _roundUp) external view returns (uint256)
```

The ```toBorrtoBorrowAmountowShares``` function converts a given amount of borrow debt into the number of shares

| Param | Type | Description |
| ---- | ---- | ----------- |
| _shares | uint256 | Shares of borrow |
| _roundUp | bool | Whether to roundup during division |

## setTimeLock

```solidity
function setTimeLock(address _newAddress) external
```

The ```setTimeLock``` function sets the TIME_LOCK address

| Param | Type | Description |
| ---- | ---- | ----------- |
| _newAddress | address | the new time lock address |

## ChangeFee

```solidity
event ChangeFee(uint32 _newFee)
```

The ```ChangeFee``` event first when the fee is changed

| Param | Type | Description |
| ---- | ---- | ----------- |
| _newFee | uint32 | The new fee |

## changeFee

```solidity
function changeFee(uint32 _newFee) external
```

The ```changeFee``` function changes the protocol fee, max 50%

| Param | Type | Description |
| ---- | ---- | ----------- |
| _newFee | uint32 | The new fee |

## WithdrawFees

```solidity
event WithdrawFees(uint128 _shares, address _recipient, uint256 _amountToTransfer)
```

The ```WithdrawFees``` event fires when the fees are withdrawn

| Param | Type | Description |
| ---- | ---- | ----------- |
| _shares | uint128 | Number of _shares (fTokens) redeemed |
| _recipient | address | To whom the assets were sent |
| _amountToTransfer | uint256 | The amount of fees redeemed |

## withdrawFees

```solidity
function withdrawFees(uint128 _shares, address _recipient) external returns (uint256 _amountToTransfer)
```

The ```withdrawFees``` function withdraws fees accumulated

| Param | Type | Description |
| ---- | ---- | ----------- |
| _shares | uint128 | Number of fTokens to redeem |
| _recipient | address | Address to send the assets |

| Return | Type | Description |
| ---- | ---- | ----------- |
| _amountToTransfer | uint256 | Amount of assets sent to recipient |

## SetSwapper

```solidity
event SetSwapper(address _swapper, bool _approval)
```

The ```SetSwapper``` event fires whenever a swapper is black or whitelisted

| Param | Type | Description |
| ---- | ---- | ----------- |
| _swapper | address | The swapper address |
| _approval | bool | The approval |

## setSwapper

```solidity
function setSwapper(address _swapper, bool _approval) external
```

The ```setSwapper``` function is called to black or whitelist a given swapper address
@dev

| Param | Type | Description |
| ---- | ---- | ----------- |
| _swapper | address | The swapper address |
| _approval | bool | The approval |

## SetApprovedLender

```solidity
event SetApprovedLender(address _address, bool _approval)
```

The ```SetApprovedLender``` event fires when a lender is black or whitelisted

| Param | Type | Description |
| ---- | ---- | ----------- |
| _address | address | The address |
| _approval | bool | The approval |

## setApprovedLenders

```solidity
function setApprovedLenders(address[] _lenders, bool _approval) external
```

The ```setApprovedLenders``` function sets a given set of addresses to the whitelist

_Cannot black list self_

| Param | Type | Description |
| ---- | ---- | ----------- |
| _lenders | address[] | The addresses whos status will be set |
| _approval | bool | The approcal status |

## SetApprovedBorrower

```solidity
event SetApprovedBorrower(address _address, bool _approval)
```

The ```SetApprovedBorrower``` event fires when a borrower is black or whitelisted

| Param | Type | Description |
| ---- | ---- | ----------- |
| _address | address | The address |
| _approval | bool | The approval |

## setApprovedBorrowers

```solidity
function setApprovedBorrowers(address[] _borrowers, bool _approval) external
```

The ```setApprovedBorrowers``` function sets a given array of addresses to the whitelist

_Cannot black list self_

| Param | Type | Description |
| ---- | ---- | ----------- |
| _borrowers | address[] | The addresses whos status will be set |
| _approval | bool | The approcal status |

