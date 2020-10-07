# Borrowing

Yield allows borrowing DAI against your ETH and pay a fixed rate. This is done by depositing ETH in the system and drawing fyDAI against it.
Then, you proceed to sell the fyDAI for DAI, locking your rate. 

At maturity, you need to repay the debt in DAI to reclaim your collateral. 

You may also repay your debt earlier than the maturity. Interest rate changes may affect (positively or negatively!) the amount you need to repay.
Be careful when repaying earlier as you may incur higher interest rates than paying at maturity.

![](../assets/borrow_1.png)  |  ![](../assets/borrow_2.png)
:-------------------------:|:-------------------------:
![](../assets/borrow_3.png)  |  ![](../assets/borrow_4.png)

## Example

Here’s an example of using the Yield protocol to borrow Dai, assuming ETH = $400, and a buyer for fyDAI 
(the buyer will in practice be [YieldSpace](../developers/yieldspace.md), Yield's application specific automated market maker). 

1. You deposit 0.5 ETH of collateral (worth $200) in the system. This allows you to borrow up to 132 fyDai from any of the available maturities. 
1. You decide on Sept. 31, 2020 to borrow 100 fyDAI-DEC20 (fyDAI expiring on December 31, 2020).
1. You sell the fyDAI-DEC20 on the open market for 98.8 DAI

Effectively, you have borrowed 98.8 DAI today and must repay 100 DAI debt in 3 months. In other words, you have borrowed at 5% APR (**TODO: Is this correct? Explain how this is calculated, since it's not a full year loan**)

After maturity is reached on Dec. 31st, 2020, you may return and pay the 100 DAI debt. If you fail to repay after maturity, your debt will grow by the MakerDAO stability fee until your position is closed either via repaying your debt or via [liquidation](../developers/liquidation.md).

## A note on collateral

Borrowers must maintain a minimum amount of collateral in the system to secure the debt they owe. 

If a borrower fails to do so, they may be liquidated: their collateral will be seized and auctioned off to repay their debts. 

For ETH collateral, fyDAI uses the same collateralization ratio as MakerDAO, which is currently 150%.
