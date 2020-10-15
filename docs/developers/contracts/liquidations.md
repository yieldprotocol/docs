# Liquidations

Borrowers must maintain a minimum amount of collateral in their vault to secure the debt they owe. If a borrower fails to do so, their vault may be liquidated: their collateral will be seized and auctioned off to repay their debts. For ETH collateral, yDai uses the same collateralization ratio as Maker, which is currently 150%.

The Liquidations contract permits any user to initiate the liquidation of an undercollateralized WETH vaults. The contract liquidates vaults via a reverse Dutch auction. A user is undercolalteralized if the `controller.isCollateralized` function returns false.

The price for the collateral in auction (paid in Dai) is defined by the `price` function. Liquidated collateral can be bought at a price that starts at half of the available collateral for all of the debt, and drops to all the available collateral for all of the debt after `Liquidations.AUCTION_TIME`. Upon reaching the final price, the auction is held open indefinitely at that price. 

Undercollateralized vaults can be liquidated by anyone by calling `liquidate`. This will result in debt and collateral records being read and removed from the Controller using `controller.erase`. The resulting debt and collateral is recorded in `Liquidations.vaults`. The starting time for the auction is recorded in `Liquidations.liquidations`.

Collateral from vaults can be bought with Dai using `buy`. Collateral vaults can be bought whole, or partially. If bought partially, more than `Liquidations.DUST` collateral must be left.

Once all debt from a vault has been repaid, liquidated users can `withdraw` any remaining collateral.

If a user is liquidated while already having a vault in `Liquidations`, the debt and collateral from both liquidations will be merged, but the auction start time won't be reset. This is a disadvantage for the liquidated user.

If a user is liquidated while having collateral to be withdrawn from `Liquidations`, the collateral will be seized and added to the starting auction. It is recommended that collateral is withdrawn as soon as possible to avoid this.

Dai taken in payment will be handed over to Treasury, and collateral assets bought will be taken from Treasury as well.

TODO: Explain how the liquidator software works
https://github.com/yieldprotocol/yield-liquidator/
