# Pool Proxy

This proxy implements the operations in the "Pool" section of the frontend.

 - `addLiquidity` takes Dai from the user and uses Chai and the Controller to convert it to the appropriate Dai/fyDai ratio for minting liquidity tokens. The client incurs Chai-collateralized debt in the Controller.
 - `removeLiquidityEarlyDaiPool` removes liquidity from a pool, sells all Dai for fyDai in the pool, repays as much debt as possible, and if there is any remaining fyDai they are sold back for Dai in the same pool. If there is any Chai collateral left in the Controller after paying all debt, it gets unwrapped into Dai and returned to the user. This function requires that the pool has enough liquidity to perform all these operations.
 - `removeLiquidityEarlyDaiFixed` removes liquidity from a pool and uses the Dai and fyDai proceedings (first fyDai, then Dai) to repay debt in the controller. If there is any fyDai left is sold in the pool and the resulting Dai is sent to the user. This function also might require liquidity in the pool, but at a lesser degree than `removeLiquidityEarlyDaiPool`.
 - `removeLiquidityMature` can be used only once the relevant series has matured. Liquidity is removed and the fyDai proceedings are redeemed for Dai. Debt is repaid in the Controller and any remaining Dai is sent to the user.