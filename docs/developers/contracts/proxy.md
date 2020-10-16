# Yield Proxy

The core contracts implement the minimum functionality for the fyDai system to exist. The `YieldProxy` is a stateless contract that implements all the convenience functionality to provide a pleasant user experience through the frontend.

Users need to authorize `YieldProxy` to act in their name with `Controller` and each `Pool`. They do this by calling `Controller.addDelegate(yieldProxy.address)` and `Pool.addDelegate(yieldProxy.address)`.

The functions performed by the proxy can be grouped in several topics.

## Onboard
The `unpack`, `onboard` and `authorizePool` functions facilitate ERC20 approvals and delegation permissions using off-chain signatures.

## Ether management
`Controller` deals with Wrapper Ether. The `post` and `withdraw` functions allow to operate with regular Ether.

## Liquidity
 - `addLiquidity` takes Dai from the user and uses Chai and the Controller to convert it to the appropriate Dai/fyDai ratio for minting liquidity tokens. The client incurs Chai-collateralized debt in the Controller.
 - `removeLiquidityEarlyDaiPool` removes liquidity from a pool, sells all Dai for fyDai in the pool, repays as much debt as possible, and if there is any remaining fyDai they are sold back for Dai in the same pool. If there is any Chai collateral left in the Controller after paying all debt, it gets unwrapped into Dai and returned to the user. This function requires that the pool has enough liquidity to perform all these operations.
 - `removeLiquidityEarlyDaiFixed` removes liquidity from a pool and uses the Dai and fyDai proceedings (first fyDai, then Dai) to repay debt in the controller. If there is any fyDai left is sold in the pool and the resulting Dai is sent to the user. This function also might require liquidity in the pool, but at a lesser degree than `removeLiquidityEarlyDaiPool`.
 - `removeLiquidityMature` can be used only once the relevant series has matured. Liquidity is removed and the fyDai proceedings are redeemed for Dai. Debt is repaid in the Controller and any remaining Dai is sent to the user.

## Borrow and repay
 - `borrowDaiForMaximumFYDai` and `borrowMinimumDaiForFYDai` enable a user to borrow fyDai and immediately trade it in the pool for Dai.
 - `repayFYDaiDebtForMaximumDai` and `repayMinimumFYDaiDebtForDai` enable a user to exchange Dai for fyDai in a pool and use the resulting Dai to repay Controller debts. This will sometimes be more advantageous to the user than using `controller.repayDai`.

## Trade
 - `buyDai`, `sellDai`, `buyFYDai` and `sellFYDai` enable a user to buy and sell assets in the pools as limit orders.
 - `buyDaiWithSignature` enables a user to buy Dai as a limit order with an off-chain signature instead of a previous `dai.approve`.

## Repay
 - `repayDaiWithSignature` enables a user to repay debt in Controller using Dai with an off-chain signature instead of a previous `dai.approve`.

## Vault Migration
 - `makerToYield` enables a user to import user debt and collateral from a MakerDAO account to make a fyDai vault of a given series in Controller.
 - `yieldToMaker` enables a user to export user debt and collateral from a fyDai series in Controller to a MakerDAO account.
