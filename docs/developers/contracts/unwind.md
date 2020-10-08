# Unwind

Unwind allows everyone to recover their assets from the Yield protocol in the event of a MakerDAO shutdown.

During the unwind process, the system debt to MakerDAO can be settled with `settleTreasury`, extracting all free weth.

Any system savings can be converted from Chai to Weth using `cashSavings`.

Users can settle their debt positions using `settle`. The MakerDAO rates will be used to convert all debt and collateral to a Weth payout.

Assets in liquidation cannot be bought once the unwind has been started. Users in liquidation can settle their positions using `settleLiquidations`. Any remaining weth collateral will be returned to the user.

Users can also redeem here their fyDai for a Weth payout, using `redeem`.