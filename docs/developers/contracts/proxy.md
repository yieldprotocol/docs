# Yield Proxies

The core contracts implement the minimum functionality for the fyDai system to exist. A number of stateless proxy contracts implement all the convenience functionality to provide a pleasant user experience through the frontend.


## BorrowProxy
`BorrowProxy` implements the functions for the "Borrow" and "Lend" sections of the frontend.

Although it is possible to use `BorrowProxy` as deployed, it is recommended to `execute` its functions from a `dsproxy`, so that any off-chain signatures processed are preserved in the case of a `BorrowProxy` upgrade.

### Ether management
`Controller` deals with Wrapper Ether. The `post` and `withdraw` functions allow to operate with regular Ether.

The `withdraw` feature also counts with `withdrawCheck` and `withdrawWithSignature` helper functions to determine missing permissions, and accept off-chain signatures.

### Borrow
 - `borrowDaiForMaximumFYDai` enables a user to borrow fyDai and immediately trade it in the pool for Dai.
 - `repayMinimumFYDaiDebtForDai` enables a user to exchange Dai for fyDai in a pool and use the resulting Dai to repay Controller debts. This will sometimes be more advantageous to the user than using `controller.repayDai`.

Helper methods:
 - `borrowDaiForMaximumFYDaiCheck` returns missing approvals or signatures for `borrowDaiForMaximumFYDai` or `borrowDaiForMaximumFYDaiWithSignature`.
 - `borrowDaiForMaximumFYDaiApprove` executes any required proxy approvals for `borrowDaiForMaximumFYDai`.
 - `borrowDaiForMaximumFYDaiWithSignature` executes `borrowDaiForMaximumFYDai` after any required proxy approvals, and with any embedded signatures.
 - `repayDaiCheck` returns which signatures are missing if intending to call `controller.repayDai` or `repayDaiWithSignature`.
 - `repayDaiWithSignature` calls `controller.repayDai` with an embedded Dai `permit`.
 - `repayMinimumFYDaiDebtForDaiCheck` returns missing approvals or signatures for `repayMinimumFYDaiDebtForDai` or `repayMinimumFYDaiDebtForDaiWithSignature`.
 - `repayMinimumFYDaiDebtForDaiApprove` executes any required proxy approvals for `repayMinimumFYDaiDebtForDai`.
 - `repayMinimumFYDaiDebtForDaiWithSignature` executes `repayMinimumFYDaiDebtForDai` after any required proxy approvals, and with any embedded signatures.

### Lend
 - `buyDai`, `sellDai` and `sellFYDai` enable a user to buy and sell assets in the pools as limit orders. These functions are used in the "Lend" section of the frontend.

Helper methods:
 - `buyDaiCheck` returns missing signatures for `buyDai` or `buyDaiWithSignature`.
 - `sellDaiCheck` returns missing signatures for `sellDai` or `sellDaiWithSignature`.
 - `sellFYDaiCheck` returns missing signatures for `sellFYDai` or `sellFYDaiWithSignature`.
 - `buyDaiWithSignature` executes `buyDai` with any embedded signatures.
 - `sellDaiWithSignature` executes `sellDai` with any embedded signatures.
 - `sellFYDaiWithSignature` executes `sellFYDai` with any embedded signatures.


## PoolProxy
`PoolProxy` implements the functions for the "Pool" section of the frontend.

Although it is possible to use `PoolProxy` as deployed, it is recommended to `execute` its functions from a `dsproxy`, so that any off-chain signatures processed are preserved in the case of a `PoolProxy` upgrade.

 - `addLiquidity` takes Dai from the user and uses Chai and the Controller to convert it to the appropriate Dai/fyDai ratio for minting liquidity tokens. The client incurs Chai-collateralized debt in the Controller.
 - `removeLiquidityEarlyDaiPool` removes liquidity from a pool, sells all Dai for fyDai in the pool, repays as much debt as possible, and if there is any remaining fyDai they are sold back for Dai in the same pool. If there is any Chai collateral left in the Controller after paying all debt, it gets unwrapped into Dai and returned to the user. This function requires that the pool has enough liquidity to perform all these operations.
 - `removeLiquidityEarlyDaiFixed` removes liquidity from a pool and uses the Dai and fyDai proceedings (first fyDai, then Dai) to repay debt in the controller. If there is any fyDai left is sold in the pool and the resulting Dai is sent to the user. This function also might require liquidity in the pool, but at a lesser degree than `removeLiquidityEarlyDaiPool`.
 - `removeLiquidityMature` can be used only once the relevant series has matured. Liquidity is removed and the fyDai proceedings are redeemed for Dai. Debt is repaid in the Controller and any remaining Dai is sent to the user.

Helper methods:
 - `addLiquidityCheck` returns missing approvals or signatures for `addLiquidity` or `addLiquidityWithSignature`.
 - `addLiquidityApprove` executes any required proxy approvals for `addLiquidity`.
 - `addLiquidityWithSignature` executes `addLiquidity` after any required proxy approvals, and with any embedded signatures.
 - `removeLiquidityEarlyDaiPoolCheck` returns missing approvals or signatures for `removeLiquidityEarlyDaiPool` or `removeLiquidityEarlyDaiPoolWithSignature`.
 - `removeLiquidityEarlyDaiPoolApprove` executes any required proxy approvals for `removeLiquidityEarlyDaiPool`.
 - `removeLiquidityEarlyDaiPoolWithSignature` executes `removeLiquidityEarlyDaiPool` after any required proxy approvals, and with any embedded signatures.
 - `removeLiquidityEarlyDaiFixedCheck` returns missing approvals or signatures for `removeLiquidityEarlyDaiFixed` or `removeLiquidityEarlyDaiFixedWithSignature`.
 - `removeLiquidityEarlyDaiFixedApprove` executes any required proxy approvals for `removeLiquidityEarlyDaiFixed`.
 - `removeLiquidityEarlyDaiFixedWithSignature` executes `removeLiquidityEarlyDaiFixed` after any required proxy approvals, and with any embedded signatures.
 - `removeLiquidityMatureCheck` returns missing approvals or signatures for `removeLiquidityMature` or `removeLiquidityMatureWithSignature`.
 - `removeLiquidityMatureApprove` executes any required proxy approvals for `removeLiquidityMature`.
 - `removeLiquidityMatureWithSignature` executes `removeLiquidityMature` after any required proxy approvals, and with any embedded signatures.


## ImportProxy
`ImportProxy` allows to migrate MakerDAO CDP vaults to Yield.

Although it is possible to use `ImportProxy` as deployed, it is recommended to `execute` its functions from a `dsproxy`, so that the `vat.hope` permissions given by the user are preserved in the case of a `ImportProxy` upgrade.

If `vat.hope` permissions were given to a `dsproxy` deployed by MakerDAO, they will be reused by Yield.

 - `importPosition` enables a user to import user debt and collateral from a MakerDAO account to make a fyDai vault of a given series in Controller.
 - `importVault` enables a user to import a MakerDAO CDP vault to make a fyDai vault of a given series in Controller.

Helper methods:
 - `importPositionCheck` returns missing approvals or signatures for `importPosition` or `importVault`.
 - `importPositionWithSignature` executes `importPosition` with any embedded signatures. If needed, `vat.hope` needs to be executed in a prior transaction.
 - `importVaultWithSignature` executes `importVault` with any embedded signatures. If needed, `vat.hope` needs to be executed in a prior transaction.


## ExportProxy
`ExportProxy` allows to migrate Yield positions to MakerDAO.

`ExportProxy` can't use `dsproxy` due to the flash minting callbacks involved. A `vat.hope` transaction must be executed before `ExportProxy.exportPosition`, and any approvals or signatures given would not be present in future versions of `ExportProxy`

 - `exportPosition` enables a user to export user debt and collateral from a fyDai series in Controller to a MakerDAO account.

Helper methods:
 - `exportPositionCheck` returns missing approvals or signatures for `exportPosition`.
 - `exportPositionWithSignature` executes `exportPosition` with any embedded signatures. If needed, `vat.hope` needs to be executed in a prior transaction.

## DSProxy
Yield uses MakerDAO's `dsproxy` to allow upgrading the proxies while keeping permissions granted by the users.
