## FraxlendPairCore

An abstract contract which contains the core logic and storage for the FraxlendPair

## constructor

```solidity
constructor(bytes _configData, bytes _immutables, uint256 _maxLTV, uint256 _liquidationFee, uint256 _maturityDate, uint256 _penaltyRate, bool _isBorrowerWhitelistActive, bool _isLenderWhitelistActive) internal
```

The ```constructor``` function is called on deployment

| Param | Type | Description |
| ---- | ---- | ----------- |
| _configData | bytes | abi.encode(address _asset, address _collateral, address _oracleMultiply, address _oracleDivide, uint256 _oracleNormalization, address _rateContract, bytes memory _rateInitData) |
| _immutables | bytes |  |
| _maxLTV | uint256 | The Maximum Loan-To-Value for a borrower to be considered solvent (1e5 precision) |
| _liquidationFee | uint256 | The fee paid to liquidators given as a % of the repayment (1e5 precision) |
| _maturityDate | uint256 | The maturityDate date of the Pair |
| _penaltyRate | uint256 | The interest rate after maturity date |
| _isBorrowerWhitelistActive | bool | Enables borrower whitelist |
| _isLenderWhitelistActive | bool | Enables lender whitelist |

## initialize

```solidity
function initialize(string _name, address[] _approvedBorrowers, address[] _approvedLenders, bytes _rateInitCallData) external
```

The ```initialize``` function is called immediately after deployment

_This function can only be called by the deployer_

| Param | Type | Description |
| ---- | ---- | ----------- |
| _name | string | The name of the contract |
| _approvedBorrowers | address[] | An array of approved borrower addresses |
| _approvedLenders | address[] | An array of approved lender addresses |
| _rateInitCallData | bytes | The configuration data for the Rate Calculator contract |

## _totalAssetAvailable

```solidity
function _totalAssetAvailable(struct VaultAccount _totalAsset, struct VaultAccount _totalBorrow) internal pure returns (uint256)
```

The ```_totalAssetAvailable``` function returns the total balance of Asset Tokens in the contract

| Param | Type | Description |
| ---- | ---- | ----------- |
| _totalAsset | struct VaultAccount | VaultAccount struct which stores total amount and shares for assets |
| _totalBorrow | struct VaultAccount | VaultAccount struct which stores total amount and shares for borrows |

| Return | Type | Description |
| ---- | ---- | ----------- |
| [0] | uint256 | The balance of Asset Tokens held by contract |

## _isSolvent

```solidity
function _isSolvent(address _borrower, uint256 _exchangeRate) internal view returns (bool)
```

The ```_isSolvent``` function determines if a given borrower is solvent given an exchange rate

| Param | Type | Description |
| ---- | ---- | ----------- |
| _borrower | address | The borrower address to check |
| _exchangeRate | uint256 | The exchange rate, i.e. the amount of collateral to buy 1e18 asset |

| Return | Type | Description |
| ---- | ---- | ----------- |
| [0] | bool | Whether borrower is solvent |

## _isPastMaturity

```solidity
function _isPastMaturity() internal view returns (bool)
```

The ```_isPastMaturity``` function determines if the current block timestamp is past the maturityDate date

| Return | Type | Description |
| ---- | ---- | ----------- |
| [0] | bool | Whether or not the debt is past maturity |

## isSolvent

```solidity
modifier isSolvent(address _borrower)
```

Checks for solvency AFTER executing contract code

| Param | Type | Description |
| ---- | ---- | ----------- |
| _borrower | address | The borrower whose solvency we will check |

## approvedBorrower

```solidity
modifier approvedBorrower()
```

Checks if msg.sender is an approved Borrower

## approvedLender

```solidity
modifier approvedLender(address _receiver)
```

Checks if msg.sender and _receiver are both an approved Lender

| Param | Type | Description |
| ---- | ---- | ----------- |
| _receiver | address | An additional receiver address to check |

## isNotPastMaturity

```solidity
modifier isNotPastMaturity()
```

Ensure function is not called when passed maturity

## AddInterest

```solidity
event AddInterest(uint256 _interestEarned, uint256 _rate, uint256 _deltaTime, uint256 _feesAmount, uint256 _feesShare)
```

The ```AddInterest``` event is emitted when interest is accrued by borrowers

| Param | Type | Description |
| ---- | ---- | ----------- |
| _interestEarned | uint256 | The total interest accrued by all borrowers |
| _rate | uint256 | The interest rate used to calculate accrued interest |
| _deltaTime | uint256 | The time elapsed since last interest accrual |
| _feesAmount | uint256 | The amount of fees paid to protocol |
| _feesShare | uint256 | The amount of shares distributed to protocol |

## UpdateRate

```solidity
event UpdateRate(uint256 _ratePerSec, uint256 _deltaTime, uint256 _utilizationRate, uint256 _newRatePerSec)
```

The ```UpdateRate``` event is emitted when the interest rate is updated

| Param | Type | Description |
| ---- | ---- | ----------- |
| _ratePerSec | uint256 | The old interest rate (per second) |
| _deltaTime | uint256 | The time elapsed since last update |
| _utilizationRate | uint256 | The utilization of assets in the Pair |
| _newRatePerSec | uint256 | The new interest rate (per second) |

## addInterest

```solidity
function addInterest() external returns (uint256 _interestEarned, uint256 _feesAmount, uint256 _feesShare, uint64 _newRate)
```

The ```addInterest``` function is a public implementation of _addInterest and allows 3rd parties to trigger interest accrual

| Return | Type | Description |
| ---- | ---- | ----------- |
| _interestEarned | uint256 | The amount of interest accrued by all borrowers |
| _feesAmount | uint256 |  |
| _feesShare | uint256 |  |
| _newRate | uint64 |  |

## _addInterest

```solidity
function _addInterest() internal returns (uint256 _interestEarned, uint256 _feesAmount, uint256 _feesShare, uint64 _newRate)
```

The ```_addInterest``` function is invoked prior to every external function and is used to accrue interest and update interest rate

_Can only called once per block_

| Return | Type | Description |
| ---- | ---- | ----------- |
| _interestEarned | uint256 | The amount of interest accrued by all borrowers |
| _feesAmount | uint256 |  |
| _feesShare | uint256 |  |
| _newRate | uint64 |  |

## UpdateExchangeRate

```solidity
event UpdateExchangeRate(uint256 _rate)
```

The ```UpdateExchangeRate``` event is emitted when the Collateral:Asset exchange rate is updated

| Param | Type | Description |
| ---- | ---- | ----------- |
| _rate | uint256 | The new rate given as the amount of Collateral Token to buy 1e18 Asset Token |

## updateExchangeRate

```solidity
function updateExchangeRate() external returns (uint256 _exchangeRate)
```

The ```updateExchangeRate``` function is the external implementation of _updateExchangeRate.

_This function is invoked at most once per block as these queries can be expensive_

| Return | Type | Description |
| ---- | ---- | ----------- |
| _exchangeRate | uint256 | The new exchange rate |

## _updateExchangeRate

```solidity
function _updateExchangeRate() internal returns (uint256 _exchangeRate)
```

The ```_updateExchangeRate``` function retrieves the latest exchange rate. i.e how much collateral to buy 1e18 asset.

_This function is invoked at most once per block as these queries can be expensive_

| Return | Type | Description |
| ---- | ---- | ----------- |
| _exchangeRate | uint256 | The new exchange rate |

## _deposit

```solidity
function _deposit(struct VaultAccount _totalAsset, uint128 _amount, uint128 _shares, address _receiver) internal
```

The ```_deposit``` function is the internal implementation for lending assets

_Caller must invoke ```ERC20.approve``` on the Asset Token contract prior to calling function_

| Param | Type | Description |
| ---- | ---- | ----------- |
| _totalAsset | struct VaultAccount | An in memory VaultAccount struct representing the total amounts and shares for the Asset Token |
| _amount | uint128 | The amount of Asset Token to be transferred |
| _shares | uint128 | The amount of Asset Shares (fTokens) to be minted |
| _receiver | address | The address to receive the Asset Shares (fTokens) |

## deposit

```solidity
function deposit(uint256 _amount, address _receiver) external returns (uint256 _sharesReceived)
```

The ```deposit``` function allows a user to Lend Assets by specifying the amount of Asset Tokens to lend

_Caller must invoke ```ERC20.approve``` on the Asset Token contract prior to calling function_

| Param | Type | Description |
| ---- | ---- | ----------- |
| _amount | uint256 | The amount of Asset Token to transfer to Pair |
| _receiver | address | The address to receive the Asset Shares (fTokens) |

| Return | Type | Description |
| ---- | ---- | ----------- |
| _sharesReceived | uint256 | The number of fTokens received for the deposit |

## mint

```solidity
function mint(uint256 _shares, address _receiver) external returns (uint256 _amountReceived)
```

The ```mint``` function allows a user to Lend assets by specifying the number of Assets Shares (fTokens) to mint

_Caller must invoke ```ERC20.approve``` on the Asset Token contract prior to calling function_

| Param | Type | Description |
| ---- | ---- | ----------- |
| _shares | uint256 | The number of Asset Shares (fTokens) that a user wants to mint |
| _receiver | address | The address to receive the Asset Shares (fTokens) |

| Return | Type | Description |
| ---- | ---- | ----------- |
| _amountReceived | uint256 | The amount of Asset Tokens transferred to the Pair |

## _redeem

```solidity
function _redeem(struct VaultAccount _totalAsset, uint128 _amountToReturn, uint128 _shares, address _receiver, address _owner) internal
```

The ```_redeem``` function is an internal implementation which allows a Lender to pull their Asset Tokens out of the Pair

_Caller must invoke ```ERC20.approve``` on the Asset Token contract prior to calling function_

| Param | Type | Description |
| ---- | ---- | ----------- |
| _totalAsset | struct VaultAccount | An in-memory VaultAccount struct which holds the total amount of Asset Tokens and the total number of Asset Shares (fTokens) |
| _amountToReturn | uint128 | The number of Asset Tokens to return |
| _shares | uint128 | The number of Asset Shares (fTokens) to burn |
| _receiver | address | The address to which the Asset Tokens will be transferred |
| _owner | address | The owner of the Asset Shares (fTokens) |

## redeem

```solidity
function redeem(uint256 _shares, address _receiver, address _owner) external returns (uint256 _amountToReturn)
```

The ```redeem``` function allows the caller to redeem their Asset Shares for Asset Tokens

| Param | Type | Description |
| ---- | ---- | ----------- |
| _shares | uint256 | The number of Asset Shares (fTokens) to burn for Asset Tokens |
| _receiver | address | The address to which the Asset Tokens will be transferred |
| _owner | address | The owner of the Asset Shares (fTokens) |

| Return | Type | Description |
| ---- | ---- | ----------- |
| _amountToReturn | uint256 | The amount of Asset Tokens to be transferred |

## withdraw

```solidity
function withdraw(uint256 _amount, address _receiver, address _owner) external returns (uint256 _shares)
```

The ```withdraw``` function allows a user to redeem their Asset Shares for a specified amount of Asset Tokens

| Param | Type | Description |
| ---- | ---- | ----------- |
| _amount | uint256 | The amount of Asset Tokens to be transferred in exchange for burning Asset Shares |
| _receiver | address | The address to which the Asset Tokens will be transferred |
| _owner | address | The owner of the Asset Shares (fTokens) |

| Return | Type | Description |
| ---- | ---- | ----------- |
| _shares | uint256 | The number of Asset Shares (fTokens) burned |

## BorrowAsset

```solidity
event BorrowAsset(address _borrower, address _receiver, uint256 _borrowAmount, uint256 _sharesAdded)
```

The ```BorrowAsset``` event is emitted when a borrower increases their position

| Param | Type | Description |
| ---- | ---- | ----------- |
| _borrower | address | The borrower whose account was debited |
| _receiver | address | The address to which the Asset Tokens were transferred |
| _borrowAmount | uint256 | The amount of Asset Tokens transferred |
| _sharesAdded | uint256 | The number of Borrow Shares the borrower was debited |

## _borrowAsset

```solidity
function _borrowAsset(uint128 _borrowAmount, address _receiver) internal returns (uint256 _sharesAdded)
```

The ```_borrowAsset``` function is the internal implementation for borrowing assets

| Param | Type | Description |
| ---- | ---- | ----------- |
| _borrowAmount | uint128 | The amount of the Asset Token to borrow |
| _receiver | address | The address to receive the Asset Tokens |

| Return | Type | Description |
| ---- | ---- | ----------- |
| _sharesAdded | uint256 | The amount of borrow shares the msg.sender will be debited |

## borrowAsset

```solidity
function borrowAsset(uint256 _borrowAmount, uint256 _collateralAmount, address _receiver) external returns (uint256 _shares)
```

The ```borrowAsset``` function allows a user to open/increase a borrow position

_Borrower must call ```ERC20.approve``` on the Collateral Token contract if applicable_

| Param | Type | Description |
| ---- | ---- | ----------- |
| _borrowAmount | uint256 | The amount of Asset Token to borrow |
| _collateralAmount | uint256 | The amount of Collateral Token to transfer to Pair |
| _receiver | address | The address which will receive the Asset Tokens |

| Return | Type | Description |
| ---- | ---- | ----------- |
| _shares | uint256 | The number of borrow Shares the msg.sender will be debited |

## _addCollateral

```solidity
function _addCollateral(address _sender, uint256 _collateralAmount, address _borrower) internal
```

The ```_addCollateral``` function is an internal implementation for adding collateral to a borrowers position

| Param | Type | Description |
| ---- | ---- | ----------- |
| _sender | address | The source of funds for the new collateral |
| _collateralAmount | uint256 | The amount of Collateral Token to be transferred |
| _borrower | address | The borrower account for which the collateral should be credited |

## addCollateral

```solidity
function addCollateral(uint256 _collateralAmount, address _borrower) external
```

The ```addCollateral``` function allows the caller to add Collateral Token to a borrowers position

_msg.sender must call ERC20.approve() on the Collateral Token contract prior to invocation_

| Param | Type | Description |
| ---- | ---- | ----------- |
| _collateralAmount | uint256 | The amount of Collateral Token to be added to borrower&#x27;s position |
| _borrower | address | The account to be credited |

## RemoveCollateral

```solidity
event RemoveCollateral(address _sender, uint256 _collateralAmount, address _receiver, address _borrower)
```

The ```RemoveCollateral``` event is emitted when collateral is removed from a borrower&#x27;s position

| Param | Type | Description |
| ---- | ---- | ----------- |
| _sender | address | The account from which funds are transferred |
| _collateralAmount | uint256 | The amount of Collateral Token to be transferred |
| _receiver | address | The address to which Collateral Tokens will be transferred |
| _borrower | address |  |

## _removeCollateral

```solidity
function _removeCollateral(uint256 _collateralAmount, address _receiver, address _borrower) internal
```

The ```_removeCollateral``` function is the internal implementation for removing collateral from a borrower&#x27;s position

| Param | Type | Description |
| ---- | ---- | ----------- |
| _collateralAmount | uint256 | The amount of Collateral Token to remove from the borrower&#x27;s position |
| _receiver | address | The address to receive the Collateral Token transferred |
| _borrower | address | The borrower whose account will be debited the Collateral amount |

## removeCollateral

```solidity
function removeCollateral(uint256 _collateralAmount, address _receiver) external
```

The ```removeCollateral``` function is used to remove collateral from msg.sender&#x27;s borrow position

_msg.sender must be solvent after invocation or transaction will revert_

| Param | Type | Description |
| ---- | ---- | ----------- |
| _collateralAmount | uint256 | The amount of Collateral Token to transfer |
| _receiver | address | The address to receive the transferred funds |

## RepayAsset

```solidity
event RepayAsset(address _sender, address _borrower, uint256 _amountToRepay, uint256 _shares)
```

The ```RepayAsset``` event is emitted whenever a debt position is repaid

| Param | Type | Description |
| ---- | ---- | ----------- |
| _sender | address | The msg.sender of the transaction |
| _borrower | address | The borrower whose account will be credited |
| _amountToRepay | uint256 | The amount of Asset token to be transferred |
| _shares | uint256 | The amount of Borrow Shares which will be debited from the borrower after repayment |

## _repayAsset

```solidity
function _repayAsset(struct VaultAccount _totalBorrow, uint128 _amountToRepay, uint128 _shares, address _payer, address _borrower) internal
```

The ```_repayAsset``` function is the internal implementation for repaying a borrow position

_The payer must have called ERC20.approve() on the Asset Token contract prior to invocation_

| Param | Type | Description |
| ---- | ---- | ----------- |
| _totalBorrow | struct VaultAccount | An in memory copy of the totalBorrow VaultAccount struct |
| _amountToRepay | uint128 | The amount of Asset Token to transfer |
| _shares | uint128 | The number of Borrow Shares the sender is repaying |
| _payer | address | The address from which funds will be transferred |
| _borrower | address | The borrower account which will be credited |

## repayAsset

```solidity
function repayAsset(uint256 _shares, address _borrower) external returns (uint256 _amountToRepay)
```

The ```repayAsset``` function allows the caller to pay down the debt for a given borrower.

_Caller must first invoke ```ERC20.approve()``` for the Asset Token contract_

| Param | Type | Description |
| ---- | ---- | ----------- |
| _shares | uint256 | The number of Borrow Shares which will be repaid by the call |
| _borrower | address | The account for which the debt will be reduced |

| Return | Type | Description |
| ---- | ---- | ----------- |
| _amountToRepay | uint256 | The amount of Asset Tokens which were transferred in order to repay the Borrow Shares |

## Liquidate

```solidity
event Liquidate(address _borrower, uint256 _collateralForLiquidator, uint256 _shares)
```

The ```Liquidate``` event is emitted when a liquidation occurs

| Param | Type | Description |
| ---- | ---- | ----------- |
| _borrower | address | The borrower account for which the liquidation occured |
| _collateralForLiquidator | uint256 | The amount of Collateral Token transferred to the liquidator |
| _shares | uint256 | The number of Borrow Shares the liquidator repaid on behalf of the borrower |

## liquidate

```solidity
function liquidate(uint256 _shares, address _borrower) external returns (uint256 _collateralForLiquidator)
```

The ```liquidate``` function allows a third party to repay a borrower&#x27;s debt if they have become insolvent

_Caller must invoke ```ERC20.approve``` on the Asset Token contract prior to calling ```Liquidate()```_

| Param | Type | Description |
| ---- | ---- | ----------- |
| _shares | uint256 | The number of Borrow Shares repaid by the liquidator |
| _borrower | address | The account for which the repayment is credited and from whom collateral will be taken |

| Return | Type | Description |
| ---- | ---- | ----------- |
| _collateralForLiquidator | uint256 | The amount of Collateral Token transferred to the liquidator |

## LeveragedPosition

```solidity
event LeveragedPosition(address _borrower, address _swapperAddress, uint256 _borrowAmount, uint256 _borrowShares, uint256 _initialCollateralAmount, uint256 _amountCollateralOut)
```

The ```LeveragedPosition``` event is emitted when a borrower takes out a new leveraged position

| Param | Type | Description |
| ---- | ---- | ----------- |
| _borrower | address | The account for which the debt is debited |
| _swapperAddress | address | The address of the swapper which conforms the FraxSwap interface |
| _borrowAmount | uint256 | The amount of Asset Token to be borrowed to be borrowed |
| _borrowShares | uint256 | The number of Borrow Shares the borrower is credited |
| _initialCollateralAmount | uint256 | The amount of initial Collateral Tokens supplied by the borrower |
| _amountCollateralOut | uint256 | The amount of Collateral Token which was received for the Asset Tokens |

## leveragedPosition

```solidity
function leveragedPosition(address _swapperAddress, uint256 _borrowAmount, uint256 _initialCollateralAmount, uint256 _amountCollateralOutMin, address[] _path) external returns (uint256 _totalCollateralBalance)
```

The ```leveragedPosition``` function allows a user to enter a leveraged borrow position with minimal upfront Collateral

_Caller must invoke ```ERC20.approve()``` on the Collateral Token contract prior to calling function_

| Param | Type | Description |
| ---- | ---- | ----------- |
| _swapperAddress | address | The address of the whitelisted swapper to use to swap borrowed Asset Tokens for Collateral Tokens |
| _borrowAmount | uint256 | The amount of Asset Tokens borrowed |
| _initialCollateralAmount | uint256 | The initial amount of Collateral Tokens supplied by the borrower |
| _amountCollateralOutMin | uint256 | The minimum amount of Collateral Tokens to be received in exchange for the borrowed Asset Tokens |
| _path | address[] | An array containing the addresses of ERC20 tokens to swap.  Adheres to UniV2 style path params. |

| Return | Type | Description |
| ---- | ---- | ----------- |
| _totalCollateralBalance | uint256 | The total amount of Collateral Tokens added to a users account (initial + swap) |

## RepayAssetWithCollateral

```solidity
event RepayAssetWithCollateral(address _borrower, address _swapperAddress, uint256 _collateralToSwap, uint256 _amountAssetOut, uint256 _sharesRepaid)
```

The ```RepayAssetWithCollateral``` event is emitted whenever ```repayAssetWithCollateral()``` is invoked

| Param | Type | Description |
| ---- | ---- | ----------- |
| _borrower | address | The borrower account for which the repayment is taking place |
| _swapperAddress | address | The address of the whitelisted swapper to use for token swaps |
| _collateralToSwap | uint256 | The amount of Collateral Token to swap and use for repayment |
| _amountAssetOut | uint256 | The amount of Asset Token which was repaid |
| _sharesRepaid | uint256 | The number of Borrow Shares which were repaid |

## repayAssetWithCollateral

```solidity
function repayAssetWithCollateral(address _swapperAddress, uint256 _collateralToSwap, uint256 _amountAssetOutMin, address[] _path) external returns (uint256 _amountAssetOut)
```

The ```repayAssetWithCollateral``` function allows a borrower to repay their debt using existing collateral in contract

| Param | Type | Description |
| ---- | ---- | ----------- |
| _swapperAddress | address | The address of the whitelisted swapper to use for token swaps |
| _collateralToSwap | uint256 | The amount of Collateral Tokens to swap for Asset Tokens |
| _amountAssetOutMin | uint256 | The minimum amount of Asset Tokens to receive during the swap |
| _path | address[] | An array containing the addresses of ERC20 tokens to swap.  Adheres to UniV2 style path params. |

| Return | Type | Description |
| ---- | ---- | ----------- |
| _amountAssetOut | uint256 | The amount of Asset Tokens received for the Collateral Tokens, the amount the borrowers account was credited |

