# Frequently Asked Questions

If you can't find the answer to your question here, please ask us in [Discord](https://discord.com/channels/752978124614008945).


## General

### Why Yield Protocol?
The goal of the Yield Protocol is to bring fixed-term, fixed-rate lending and borrowing to decentralized finance. Today most of the popular decentralized finance protocols are floating-rate. While floating-rate lending/borrowing is a powerful tool, it comes with significant drawbacks. Decentralized finance has several use cases that can be greatly improved with fixed-rate, fixed-term borrowing, and lending.

### When telegram?
We have a thriving community in [Discord](https://discord.com/channels/752978124614008945), join us there!

### Wen Token?
We currently don't have any tokens neither do we have any plans for the tokens. Be careful out there!

### If there are no tokens then how do developers plan to make money on the project?
We currently don't have any plans for making money. We are focused on providing the best user experience for fixed-rate borrowing and lending.

### What differentiates Yield Protocol from other lending protocols?
Yield is focused on delivering fixed-rate, fixed-term lending and borrowing which didn't really exist in Defi until Yield pioneered it.

### How can I find you on uniswap?
Yield Protocol has no governance token. You will not find us on Uniswap, and you should be wary about any token claiming to be from Yield Protocol.

You may find the fyDai or fyDaiLP tokens created by the protocol on Uniswap or other exchanges since they are ERC-20 assets. We recommend using those assets with the [Yield App](https://app.yield.is) since the app is tailored to the particularities of trading those assets.

### What is fyDai Token?
fyDai(fixed yield Dai) tokens are Ethereum-based tokens (ERC20) that may be redeemed one-for-one Dai after a predetermined maturity date. It enables fixed-rate borrowing and lending of Dai. fyDai are analogous to zero-coupon or discount bonds.

### Does the Yield Protocol have developer fees?
Yield Protocol v1 does not have developer fees. Users of the Yield App will pay fees for borrowing and lending via their use of the YieldSpace liquidity pools. All fees in the liquidity pools go to liquidity providers.

### Fee in the AMM is 0.3% right? Like Uniswap's?
No, it’s calculated differently. It’s approximately 5% of the interest paid. You can read about fees in the [YieldSpace paper](https://yield.is/YieldSpace.pdf) or in these docs.

### What is the fee structure? Formula/parameters?
In other protocols, fees are typically charged in proportion to the amount being sold.  In the Yield App liquidity pools, prices are computed in “yield space” rather than “price space”—meaning that the fees impose a proportional spread on interest rates, rather than on prices. The exact fee calculation is detailed in our [YieldSpace paper](https://yield.is/YieldSpace.pdf) in Section 5. As a rough approximation, the fee is about 5% of the current interest rate. For example, when the marginal interest rate of an automated liquidity pool is 10%, a borrower might see a marginal interest rate of ≈10.55%, while a lender might see a marginal interest rate of ≈9.47%.

### What assets can be borrowed or lent? What collateral can be used?
The Yield Protocol v1 only permits borrowing and lending of Dai, and only accepts ETH and Chai collateral. Chai collateral is not currently supported in the Yield App.

### Can anyone set up a new series/collateral/underlying in Yield, as it is done in Uniswap?
Yield v1 can't be extended with new assets neither by the public nor the development team.

### What is maturity?
The maturity of a series is the date at which its fyDai token can be redeemed for Dai at one Dai for each fyDai. Before maturity fyDai can be traded in the Pool for Dai at a market rate.

### How is APR calculated?

The APR for various series in the Yield App is set by automated liquidity pools. The interest rate (and price) that an automated liquidity pool trades at is determined by the current reserves of fyDai and Dai held in the pool. The mid-market APR (the average of the borrowing and lending APRs) can be calculated with the following formula:

$$
(\frac{fyDaiReserves}{DaiReserves})^\frac{1}{4} - 1
$$

### Is Yield Protocol audited?
Yes! By Trails of Bits, [here is the report](https://github.com/trailofbits/publications/blob/master/reviews/YieldProtocol.pdf).

### Would there be an auto-roll feature?
We are working on debt, lending, and liquidity rolling. It will be available in our upcoming release.

### Why do we need to create a proxy account?
So that we can upgrade our features at no cost to users. You can learn more about it from our [blog post](https://medium.com/yield-protocol/upgrades-to-the-yield-app-6d8c45ed3a27)

### Is this built with UMA?
Yield is not built with UMA. It is built on top of Maker.

### Are there any major differences between fyDai and UMA's uUSD?

When Yield Protocol's fyDai expires it is redeemable for Dai, so the fixed rate becomes a variable rate (the DSR). This could be seen as "opening a CDP on the borrower's behalf."

When UMA's uUSD expires, the outstanding uUSD becomes "de-pegged", and redeemable for the underlying collateral: WETH for uUSDwETH, renBTC for uUSDrBTC.

In UMA you can use any asset approved by the UMA governance, while in Yield v1 you will use Dai for Lending and Liquidity or Eth for Borrowing.

On the pool mechanics, uUSD primarily trades on Balancer, which is not optimised to trading maturing assets.
As the uUSD approaches maturity the slippage in interest rate terms gets higher, and the fee (also in interest rate terms)
also gets higher. Additionally, as time passes, the uUSD price offered by the Balancer pool remains the same, when it should
gradually increase at the current interest rate. Really close to maturity, paying even a 0.1% fee might actually be more
than you’re getting in interest.

YieldSpace (the Yield pools) is optimised for maturing assets and the fee and slippage are charged in interest rate terms. The fee is about 5% of the interest, so as the time approaches maturity, prices approach 1 and the fees approach 0. You can find more details in Section 5 of the paper https://yield.is/YieldSpace.pdf

### Where we can look up total liquidity figures along with pool apy?
If you click each series of the pool you should be able to find the number of liquidity tokens of each pool. In the future, the Yield team plans to build analytics tools to supplement this information with current liquidity and returns.

### How much does it cost to use the Yield Protocol?
Below there is a table with the maximum reported cost in GAS of the actions that you can take with Yield. Use the [Eth Gas Station Tx Calculator](https://ethgasstation.info/calculatorTxV.php) to find out the current USD cost.

```
Post ETH           - 163,000 GAS - borrowProxy.post
Withdraw ETH       -  87,000 GAS - borrowProxy.withdraw
Borrow Dai         - 235,000 GAS - borrowProxy.borrowDaiForMaximumFYDai
Repay Borrowing    - 312,000 GAS - borrowProxy.repayDai

Lend Dai           - 124,000 GAS - borrowProxy.sellDai
Close Lending      - 190,000 GAS - borrowProxy.buyDai

Add Liquidity      - 477,000 GAS - poolProxy.addLiquidity
Remove Liquidity   - 312,000 GAS - poolProxy.repayDai

Redeem fyDai       - 240,000 GAS - fyDai.redeem
```

### Which Yield-named products we are not.
Sorry for the confusion, we started back in 2019 but since the launch of yield farming, everyone is adding yield to their name.
yield.app
yieldprotocol.org
yield.credit
Yield Dollar(UMA)

## Providing Liquidity

### What's the difference between pool and lend?
You lend at a fixed rate. When you pool, you provide liquidity for both borrowing and lending. The returns to pooling depend on the fees earned by the pool and the path taken by interest rates.

### Why would I want to be a Liquidity Provider?
To earn fees from users trading between fyDai and Dai. Traditionally, providing liquidity has provided good returns compared to other ways to get passive returns.

### Why would an LP want to supply liquidity instead of supplying it to Compound, Curve, Uniswap, etc.?
The automated liquidity pools the Yield App permit users to earn fees like other available liquidity pools, without risk of impermanent loss if liquidity is provided to maturity.

### Is there any incentive or reward for liquidity providers besides trading fees?
There are no yield farming incentives or other token rewards in Yield. All returns are from fees paid by users.

### Is it right that you don't have impermanent loss as a Liquidity Provider in Yield?
If you add liquidity to a pool and remove it only after maturity, you won't have a loss. If you remove your liquidity before maturity your profit or loss will depend on the fees earned by the pool and the path taken by the interest rates.

### As a liquidity provider is the yield for all series the same?
No, liquidity providers earn fees for trading in that series between Dai and fyDai, so the yield is dependent upon trading volume for each series.

### How do interest rates and fyDai prices relate to each other?
They are inversely correlated. If the fyDai price for a series increases, the interest rate for that series goes down.

### Do I have 50% exposure to fyDai if I provide liquidity to a pool?

When providing liquidity to a pool, you are not 50% exposed to fyDai. Most of the time, the pool mostly holds Dai.
Behind the scenes, the contracts help you to add the fyDai portion of your liquidity addition.
Thus, if you pool and then interest rates change and you withdraw the next day, you could have impermanent loss unless fees and interest make up for it. This could happen whether fyDai prices fall or if they rise. However, this loss really is impermanent. If you hold to maturity then you won't make a loss in Dai terms.

### I added X Dai to a pool. I then tried to remove 1 Dai, but I didn't receive anything. What happened?
When adding liquidity to the pool, some of your Dai is used to borrow fyDai tokens. When you burn tokens, the debt of those borrowed tokens is paid first. No funds are lost, but burning small amounts of tokens may result in no funds being retrieved. We are working on a solution. The only current workaround is to burn all of your liquidity tokens to retrieve all the funds available to you.


## Lending and Borrowing

### How to take out a loan? What is the process?
You deposit ETH as collateral and borrow Dai. There are different maturities to choose from with different APR. The rate that you pay is fixed if you close the loan at the time of maturity. At the time of maturity, you can pay back the amount you owed and receive your collateral back.

### How much collateral is required for borrowing?
150%.

### Do we earn interest on the collateral?
Yield v1 doesn't earn interest on deposited collateral.

### What happens if I don't close the loan at the time of maturity?
Your collateral stays in yield but you start paying the Maker ETH-A stability fees which is floating-rate APR. You can of course pay back at maturity to avoid that and get your collateral back. You might also get liquidated if your collateral ratio drops below 150%.

### How does lending work in Yield?
To lend Dai using Yield, you buy fyDai, paying Dai for it.

### If I lend money for a particular series, does that mean my amount is locked for the duration of that series?
No. You can leave the lending position early but that may affect your returns and interest rates changing significantly can make your returns negative.

### Can I purchase yfDAI directly using DAI?
Yes. Buying fyDai is equivalent to lending.

### How do you calculate the Portfolio Value?
Portfolio value (at maturity) is the fyDai balance which represents the amount of Dai that the fyDai can be redeemed for at maturity.

### Lending and Borrowing rates look identical to me? How is that sustainable?
For very small amounts the rates remain identical but as the trade grows in size the rates move away from each other.

### I lent some Dai, and the Current Value is shown as less than I invested, why?
When you lend, you are selling Dai to the pool and getting fyDai back. When you close your position you are selling the fyDai that you got before, and getting Dai. Both operations in the pool involve paying a fee of approximately 5% of the interest paid. The portfolio value is thus reduced by the trading fee, and the Current Value reflects the return on selling the fyDai in the pool, which reflects the fee, interest rate changes, and slippage.

### As a lender, how do interest rate changes affect me?
Lenders are holding fyDai. If interest rates go up, the value of lenders’ holdings goes down. However, if they hold to maturity, then this decline in present value is exactly cancelled out by the increase in the interest that they earn. Borrowers are effectively short fyDai—to exit their position early they have to buy fyDai.

### As a borrower, what happens if I miss the repayment date?
When a series matures, your Yield Vault will start to owe the Maker stability fee on the debt. If your debt increases enough to bring your Yield Vault under the collateralization rate you might be liquidated.

### As a lender, what happens if I don't close my position on the repayment date?
When a series matures, the fyDai that you hold, representing your lending position, starts to accrue value at the same rate as MakerDAO's DSR. In other words, your fyDai becomes equivalent to Chai on maturity.

### Do we need to do anything once a series has matured?**
You don't have to but you should.
If you are a borrower, your debt will increase with MakerDAO's stability fees which is a variable rate and you also have to make sure that you are collateralized to avoid liquidation.
If you are a lender, you will accrue MakerDAO's DSR on your position, you can leave it as it is if you are happy with that. Holding fyDai after maturity is equivalent to holding Chai.
If you are a liquidity provider, you should remove it (and maybe add it to another series), since mature pools don't accrue any fees for liquidity providers.


## Liquidations

### What is Liquidation?
Borrowers must maintain a minimum amount of collateral in their vault to secure the debt they owe. If a borrower fails to do so, their vault may be liquidated: their collateral will be seized and auctioned off to repay their debts. For ETH collateral, fyDai uses the same collateralization ratio as Maker ETH-A, which is currently 150%.

### How does liquidation work?
Yield uses a dutch auction to sell ETH for Dai when there is a liquidation. You can read more about it in our [docs](https://docs.yield.is/developers/contracts/liquidations.html) and on our [GitHub](https://github.com/yieldprotocol/yield-liquidator).

### Who liquidates positions?
Yield currently runs a liquidation bot, but long term we expect the community to perform liquidations. We have not tried to make the bot especially competitive compared to some of the sophisticated liquidators out there.
