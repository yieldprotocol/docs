# Borrow Proxy

This proxy manages the basic operations in the "Borrow" and "Lend" sections of the frontend.

`Controller` deals with Wrapper Ether. The `post` and `withdraw` functions allow to operate with regular Ether.
 - `borrowDaiForMaximumFYDai` and `borrowMinimumDaiForFYDai` enable a user to borrow fyDai and immediately trade it in the pool for Dai.
 - `repayFYDaiDebtForMaximumDai` and `repayMinimumFYDaiDebtForDai` enable a user to exchange Dai for fyDai in a pool and use the resulting Dai to repay Controller debts. This will sometimes be more advantageous to the user than using `controller.repayDai`.
 - `repayDaiWithSignature` enables a user to repay debt in Controller using Dai with an off-chain signature instead of a previous `dai.approve`.
 - `buyDai`, `sellDai`, `buyFYDai` and `sellFYDai` enable a user to buy and sell assets in the pools as limit orders. These are used for lending.

