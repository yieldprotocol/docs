# Frequently Asked Questions

If you can't find the answer to your question here, please ask us in [Discord](https://discord.com/channels/752978124614008945).


## General

### How can I find you on uniswap?
Yield Protocol has no governance token. You will not find us on Uniswap, and you should be wary about any token claiming to be from Yield Protocol. 

You may find the fyDai or fyDaiLP tokens created by the protocol on Uniswap or other exchanges since they are ERC-20 assets. We recommend using those assets with the [Yield App](https://app.yield.is) since the app is tailored to the particularities of trading those assets. 

### When will you release a governance token?
There are no current plans to release a governance token.

### Does the Yield Protocol have developer fees?  
Yield Protocol v1 does not have developer fees. Users of the Yield App will pay fees for borrowing and lending via their use of the YieldSpace liquidity pools. All fees in the liquidity pools go to liquidity providers. 

### How is APR calculated?

The APR for various series in the Yield App are set by automated liquidity pools. The interest rate (and price) that an automated liquidity pool trades at is determined by the current reserves of fyDai and Dai held in the pool. The mid-market APR (the average of the borrowing and lending APRs) can be calculated with the following formula: 

$$
(\frac{fyDaiReserves}{DaiReserves})^\frac{1}{4} - 1
$$

### Fee in the AMM is 0.3% right? Like Uniswap's?
No, it’s calculated differently. It’s approximately 5% of the interest paid. You can read about fees in the [YieldSpace paper](https://yield.is/YieldSpace.pdf) or in these docs.

### What is the fee structure? Formula/parameters?
In other protocols, fees are typically charged in proportion to the amount being sold.  In the Yield App liquidity pools, prices are computed in “yield space” rather than “price space”—meaning that the fees impose a proportional spread on interest rates, rather than on prices. The exact fee calculation is detailed in our [YieldSpace paper](https://yield.is/YieldSpace.pdf) in Section 5. As a rough approximation, the fee is about 5% of the current interest rate. For example, when the marginal interest rate of an automated liquidity pool is 10%, a borrower might see a marginal interest rate of ≈10.55%, while a lender might see a marginal interest rate of ≈9.47%.

### When telegram?
We have a thriving community in [Discord](https://discord.com/channels/752978124614008945), join us there!

### What assets can be borrowed or lent? What collateral can be used. 
The Yield Protocol v1 only permits borrowing and lending of Dai, and only accepts ETH and Chai collateral. Chai collateral is not currently supported in the Yield App. 

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

YieldSpace (the Yield pools) is optimised for maturing assets and the fee and slippage is charged in interest rate terms. The fee is about 5% of the interest, so as time approaches maturity, prices approach 1 and the fees approach 0. You can find more details on Section 5 of the paper https://yield.is/YieldSpace.pdf

### Where we can look up for total liquidity figures along with pool apy?
If you click each series of the pool you should be able to find the number of liquidity tokens of each pool. In the future, the Yield team plans to build analytics tools in the future to supplement this information with current liquidity and returns.

### How much does it cost to use the Yield Protocol
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


## Providing Liquidity

### Why would I want to be a Liquidity Provider?
To earn fees from users trading between fyDai and Dai. Traditionally, providing liquidity has provided good returns compared to other ways to get passive returns.

### Why would an LP want to supply liquidity instead of supplying it to Compound, Curve, Uniswap, etc.?
The automated liquidity pools the Yield App permit users to earn fees like other available liquidity pools, without risk of impermanent loss if liquidity is provided to maturity. 

### Is there any LP incentive/gov token?
There are no governance tokens for Yield, and therefore, no yield farming incentives. All returns are from fees paid by users. 

### What's the difference between pool and lend?
You lend at a fixed rate. When you pool, you provide liquidity for both borrowing and lending. The returns to pooling depends on the fees earned by the pool and the path taken by interest rates.

### Is it right that you don't have impermanent loss as a Liquidity Provider in Yield?
If you add liquidity to a pool and remove it only after maturity, you won't have a loss. If you remove your liquidity before maturity your profit or loss will depend on the fees earned by the pool and the path taken by the interest rates.

### Do I have 50% exposure to fyDai if I provide liquidity to a pool?

When providing liquidity to a pool, you are not 50% exposed to fyDai. Most of the time, the pool mostly holds Dai.
Behind the scenes the contracts help you to add the fyDai portion of your liquidity addition.
Thus, if you pool and then interest rates change and you withdraw the next day, you could have impermanent loss unless fees and interest make up for it. This could happen whether fyDai prices fall or if they rise. However, this loss really is impermanent. If you hold to maturity then you won't make a loss in Dai terms.

### I added X Dai to a pool. I then tried to remove 1 Dai, but I didn't receive anything. What happened? 
When adding liquidity to the pool, some of your Dai is used to borrow fyDai tokens. When you burn tokens, the debt of those borrowed tokens is paid first. No funds are lost, but burning small amounts of tokens may result in no funds being retrieved. We are working on a solution. The only current workaround is to burn all of your liquidity tokens to retrieve all the funds available to you.


## Lending

### If I lend, is it a fixed term or can I stop lending when I choose
You can stop lending when you choose. Withdrawing early may result in a loss of principal if interest rates rise significantly. 

### How do you calculate the Portfolio Value?
Portfolio value (at maturity) is the fyDai balance which represents the amount of Dai that the fyDai can be redeemed for at maturity.

### I lent some Dai, and the Current Value is show as less that I invested, why?
when you lend you are selling Dai to the pool, and getting fyDai back. When you close your position you are selling the fyDai that you got before, and getting Dai. Both operations in the pool involve paying a fee of approximately 5% of the interest paid. The portfolio value is thus reduced by the trading fee, and the Current Value reflects the return on selling the fyDai in the pool, which reflects the fee, interest rate changes, and slippage.
