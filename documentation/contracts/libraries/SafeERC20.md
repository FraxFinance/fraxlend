

## safeSymbol

```solidity
function safeSymbol(contract IERC20 token) internal view returns (string)
```

Provides a safe ERC20.symbol version which returns &#x27;???&#x27; as fallback string.

| Param | Type | Description |
| ---- | ---- | ----------- |
| token | contract IERC20 | The address of the ERC-20 token contract. |

| Return | Type | Description |
| ---- | ---- | ----------- |
| [0] | string | (string) Token symbol. |

## safeName

```solidity
function safeName(contract IERC20 token) internal view returns (string)
```

Provides a safe ERC20.name version which returns &#x27;???&#x27; as fallback string.

| Param | Type | Description |
| ---- | ---- | ----------- |
| token | contract IERC20 | The address of the ERC-20 token contract. |

| Return | Type | Description |
| ---- | ---- | ----------- |
| [0] | string | (string) Token name. |

## safeDecimals

```solidity
function safeDecimals(contract IERC20 token) internal view returns (uint8)
```

Provides a safe ERC20.decimals version which returns &#x27;18&#x27; as fallback value.

| Param | Type | Description |
| ---- | ---- | ----------- |
| token | contract IERC20 | The address of the ERC-20 token contract. |

| Return | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint8 | (uint8) Token decimals. |

