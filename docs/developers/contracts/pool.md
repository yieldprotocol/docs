# Pool

YieldSpace is an automated liquidity provider for fyTokens. The Pool contract provides YieldSpace pools for fyDai. Using the Pool contract, users may swap Dai and fyDai of a particular series. Each series of fyDai requires its own pool. 

YieldSpace pools use a new formula for automated liquidity provision called the "constant power sum invariant." When swapping Dai and fyDai, prices are determined by the constant power sum invariant based on the pool's reserves of Dai and fyDai. 

<figure class="image" align = "center">
$$
x^{1-t} + y^{1-t} = k
$$
  <figcaption><i>The constant power sum invariant</i></figcaption>
  <br>
</figure>

The constant power sum invariant permits YieldSpace pools to operate in "yield space" rather than "price space". Specifically, the interest rate--not the price--is a pure function of reserves. 

As in Uniswap, users can add liquidity to a pool by providing Dai and fyDai in proportion to the reserves that are already in the pool. When users provide liquidity, they are minted a proportional share of liquidity tokens. Users may later burn these liquidity tokens to retrieve their share of the liquidity pool. 

To improve capital efficiency, some of the fyDai reserves are "virtual." Virtual reserves are reserves that are treated as being present for the purpose of determining a swap price, but are never actually provided by liquidity providers. 

To motivate the use of virtual reserves, consider that under normal circumstances, 1 fyDAI will never naturally trade at a higher price than 1 DAI (which would correspond to a negative interest rate). This property is maintained by arbitrage; the Yield Protocol permits users to borrow virtually unlimited amounts of fyDai in exchange for 1 Dai's worth of Chai collateral per fyDai. If fyDai prices exceed 1, users may effectively mint unlimited amount of fyDai at the price of 1 until all demand above that price is satisfied. Thus, there is a portion of the yDai reserves that the pool will never touch. These reserves can safely be made virtual. 

YieldSpace pools do not permit the price of fyDai to trade to a price above 1, and any trade that would result in a price above 1 will fail. Because the redemption value of fyDai can exceed 1 Dai after maturity, YieldSpace pools only permit trading before maturity. 

Pools must be initialized with equal reserves of Dai and yDai, implying a price of 1 and an interest rate of 0%. Once a pool is initialized, users may trade with it to push it to the market interest rate.

To save gas, YieldSpace pools uses reduced precision math operators which cause the swap results to deviate by a controlled amount from the exact result provided by full precision methods. To ensure that the reduced precision does not cause losses to liquidity providers, the output of all trades is reduced by a small amount called the "error guard". The error guard is 10^12 Wei, or about $0.000001. Any outputs below the error guard are rounded to zero. 

## Pool.sol
Each `Pool` contract is an ERC20 contract that manages reserves of Dai and a fyDai of a specific maturity. Each pool implements three groups of functions:
 - `mint` and `burn` which create and destroy the pool tokens, which represent liquidity provided to the pool. To `mint` liquidity tokens the user needs to provide Dai and fyDai liquidity in the same proportion as it already exists in the Pool. When liquidity tokens `burn`, they return to the user fyDai and Dai in the same proportion as they are in the pool, also proprotional to the user share of liquidity tokens towards the total supply.
 - `sellAssetPreview` and `buyAssetPreview` returns the result of a potential trade for an "Asset" (Dai ot fyDai), limited only by the checks in `YieldMath.sol`.
 - `sellAsset` and `buyAsset` realize the necessary checks and asset transfers to execute a trade.

## YieldMath.sol
This library uses `Math64x64.sol` to implement three groups of functions:
 - Customized `log` and `exp` functions that save as much gas as possible, including by calculating results only to a pre-set precision.
 - `assetOneInForAssetTwoOut` functions, which calculate the amount of "Asset One" which is required to buy a precise amount of "Asset Two" from the Pool.
 - `assetOneOutForAssetTwoIn` functions, which calculate the amount of "Asset One" which is obtained by selling a precise amount of "Asset Two" to the Pool.

## Math64x64.sol
This library provides fixed-point arithmetic in a 64.64 binary format.