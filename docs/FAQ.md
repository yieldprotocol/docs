# Frequently Asked Questions

If you can't find the answer to your question here, please ask us in [Discord](https://discord.com/channels/752978124614008945).


## General

### How is the Yield Protocol monetized?
The Yield company doesn't have a monetization plan yet. All fees in the liquidity pools go to liquidity providers.

### How can I find you on uniswap?
There is no governance token. You will not find us on uniswap. You could find the fyDai or fyDaiLP tokens on Uniswap or other exchanges, but you should get better prices for them in [Yield](app.yield.is) since we are tailored to the paticularities of trading fyDai, such as maturity.

### When will you release a governance token?
There are no current plans to release a governance token.

### How is APR calculated?

(getFyDaiReserves / getDaiReserves)^(1/4) - 1 should be APR (3 months to maturity)
pool.sellFYDaiPreview(1)**(time to maturity in years) - 1

### What is the fee structure? Formula/parameters?
The fee structure is detailed in our [YieldSpace paper](https://yield.is/YieldSpace.pdf). See Section 5.

### When telegram?
We have a thriving community in [Discord](https://discord.com/channels/752978124614008945), join us there!

### Does MakerDAO have to have support for all assets that can be listed on yield?
Yield only works for Dai for v1 and only accepts ETH collateral

### Is this built with UMA?
Yield is not built with UMA. It is built on top of Maker

### Are there any major differences between fyDai and UMA's uUSD?
The two main differences are the collateral asset and the pool mechanics.

In UMA you can use any asset approved by the UMA governance, while in Yield you will use Dai for Lending and Liquidity or Eth for Borrowing. Post maturity on uUSD you will have exposure to ETH, while in Yield you will have exposure to Dai.

On the pool mechanics, UMA uses Balancer, which is not optimised to trading maturing assets. As the uUSD approaches maturity the slippage in interest rate terms gets higher, and the fee (also in interest rate terms) also gets higher. Additionally, as time passes, the uUSD price offered by the Balancer pool remains the same, when it should gradually increase at the current interest rate. Really close to maturity, paying even a 0.1% fee might actually be more than you’re getting in interest.

YieldSpace (the Yield pools) is optimised for maturing assets and the fee and slippage is charged in interest rate terms. The fee is about 5% of the interest, so as time approaches maturity, prices approach 1 and the fees approach 0. You can find more details on Section 5 of the paper https://yield.is/YieldSpace.pdf

### Where we can look up for total liquidity figures along with pool apy?
We are working on an analytics tool but because we are a small team and time to market waits for no one, a lot of this still has to be done manually
If you click each series of the pool you should be able to find the liquidity of each pool.

### How much does it cost to use the Yield Protocol
Below there is a table with the maximum reported cost in GAS of the actions that you can take with Yield. Use the [Eth Gas Station Tx Calculator](https://ethgasstation.info/calculatorTxV.php) to find out the current USD cost.

Main authorisation - 131,000 GAS - proxy.onboard
Each series unlock - 171,000 GAS - proxy.authorizePool

Post ETH           - 163,000 GAS - proxy.post
Withdraw ETH       -  87,000 GAS - proxy.withdraw
Borrow Dai         - 235,000 GAS - proxy.borrowDaiForMaximumFYDai
Repay Borrowing    - 312,000 GAS - proxy.repayDaiWithSignature

Lend Dai           - 124,000 GAS - proxy.sellFYDai
Close Lending      - 190,000 GAS - proxy.buyDaiWithSignature

Add Liquidity      - 477,000 GAS - proxy.addLiquidity
Remove Liquidity   - 312,000 GAS - proxy.repayDaiWithSignature

Redeem fyDai       - 240,000 GAS - fyDai.redeem

### I had to sign and authorize nine times before being able to provide liquidity. Why are there so many steps?
The Yield Protocol is coded as a set of core contracts that provide very basic, but very robust, functionality. A separate contract (the YieldProxy) exists to allow users to interact with the core contracts easily. The first transaction authorizes the YieldProxy to act with your assets in the core contracts. Within that first transaction we embed an extra signature to allow the YieldProxy to access the Dai in your wallet. You will see this as three confirmations in your browser, the first two instantaneous, and the second taking as much time as the blockchain takes to process it.

By using off-chain signatures this becomes a single transaction, and costs about 130,000 gas. Check with [Eth Gas Station](https://ethgasstation.info/calculatorTxV.php) for the current cost.

Each series is an ERC20 token that acts as a Pool for Dai and fyDai of a certain maturity. To interact with each series you need to authorize the YieldProxy to trade for you in the pool, to access the fyDai of that series in your wallet, and for the pool to access the dai in your wallet. You will see three instantaneous confirmations, which get bundled in a single transaction. The cost of unlocking each series is about 170,000 gas.

If you just want to test the functionality you can just do the main authorization and unlock just one series. At the time of writing (378 USD/ETH and 40 Gwei/GAS) that would cost you $4.30.

### Fee in the AMM is 0.3% right? Like Uniswap's?
No, it’s calculated differently. It’s approximately 5% of the interest paid. You can read about fees in the [YieldSpace paper](https://yield.is/YieldSpace.pdf) or in these docs.



## Providing Liquidity

### Why would I want to be a Liquidity Provider?
To earn fees from people trading between fyDai and Dai.

### Why would an LP want to supply DAI at 2.6% for October instead of supplying to Compound at 2.82%?
Interest rate paid to liquidity providers in 2.6% here is fixed, Compound rates are variable based on supply/demand so there is potential for 2.82% to decrease if other people want to take advantage of that opportunity.

### Is there any LP incentive/gov token, or do you just get the yield for being an LP?
There are no governance tokens for Yield, what you see is what you get.

### What's the difference between pool and lend
You can lend at a fixed rate.
When you pool, you provide liquidity for both borrowing and lending. The returns to pooling depends on the fees earned by the pool and the path taken by interest rates.

### Is it right that you don't have impermanent loss as a Liquidity Provider in Yield?
If you add liquidity to a pool and remove it only after maturity, you won't have a loss. If you remove your liquidity before maturity your profit or loss will depend on the fees earned by the pool and the path taken by the interest rates.

### Do I have 50% exposure to fyDai if I provide liquidity to a pool?
The basic idea there is right, although actually a few subtleties. You're not 50% exposed to fyDai — most of the time, the pool mostly holds Dai.
Behind the scenes the contracts help you to add liquidity by pooling directly part of your Dai, and using the rest of your Dai as collateral to borrow the fyDai part of your liquidity addition.
So actually if you pool and then interest rates change and you withdraw the next day, you could have impermanent loss unless fees and interest make up for it. This could happen whether fyDai prices fall or if they rise. However, this loss really is impermanent. If someone holds to maturity then they won't make a loss in Dai terms.

### I added X Dai to a pool. I then tried to remove 1 Dai, but I didn't receive anything. What happened? 
When adding liquidity to the pool, some of your Dai is used to borrow fyDai tokens. When you burn tokens, the debt of those borrowed tokens is paid first. No funds are lost, but burning small amounts of tokens may result in no funds being retrieved. We are working on a solution. The only current workaround is to burn all of your liquidity tokens to retrieve all the funds available to you.



## Borrowing

If you can't find the answer to your question here, please ask us in [Discord](https://discord.com/channels/752978124614008945).



## Lending

### If I lend, is it a fixed term or can I stop lending when I choose
You can stop lending when you choose.

### How do you calculate the Portfolio Value?
The portfolio value is calculated as `(fyDai * APR) / (days to maturity / 365)`

### I lent some Dai, and the Current Value is show as less that I invested, why?
when you lend you are selling Dai to the pool, and getting fyDai back. When you close your prosition you are selling the fyDai that you got before, and getting Dai.
Both operations in the pool attract a fee of around 5% on the interest rate. If that specific maturity has an interest rate of a 3%, the fee would be of about (0.03 * 0.05 * trade size) in Dai.
The portfolio value has already deducted the `lend` fee, and the Current Value reflects the return on selling the fyDai in the pool, which reflects the fee, interest rate changes, and slippage.