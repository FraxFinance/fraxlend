
## VaultAccountingLibrary

Provides a library for use with the VaultAccount struct, provides convenient math implementations

_Uses uint128 to save on storage_

## toShares

```solidity
function toShares(struct VaultAccount total, uint256 amount, bool roundUp) internal pure returns (uint256 shares)
```

Calculates the shares value in relationship to `amount` and `total`

_Given an amount, return the appropriate number of shares_

## toAmount

```solidity
function toAmount(struct VaultAccount total, uint256 shares, bool roundUp) internal pure returns (uint256 amount)
```

Calculates the amount value in relationship to `shares` and `total`

_Given a number of shares, returns the appropriate amount_

