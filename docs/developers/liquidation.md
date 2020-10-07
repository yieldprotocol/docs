# Liquidations

Borrowers must maintain a minimum amount of collateral in their vault to secure the debt they owe. 

If a borrower fails to do so, their vault may be liquidated: their collateral will be seized and auctioned off to repay their debts. For ETH collateral, yDai uses the same collateralization ratio as Maker, which is currently 150%.

TODO: Explain the liquidation -> auction process & how the liquidator software works
https://github.com/yieldprotocol/yield-liquidator/
