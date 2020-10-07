# Interest Rate Speculation using Chai

In addition to borrowing fyDai using ETH collateral, users may also borrow fyDai by 
posting Chai (a wrapped version of Dai that earns the Dai Savings Rate). Borrowing 
fyDai against Chai is roughly equivalent to receiving floating rates and paying fixed rates. 

Sophisticated users can use this property to speculate on future changes in interest rates.

For every 1 Dai worth of Chai collateral, a user may borrow up to 1 fyDai. Because the Dai 
redemption value of Chai never goes down, fyDai borrowed with Chai is fully collateralized 
and there are no liquidations of fyDai backed by Chai collateral. 
There is also no requirement to maintain a collateralization ratio of 150% as there is with ETH.

Users can obtain significant leverage by repeatedly borrowing fyDai against Chai, 
selling it for Chai, depositing it as collateral, and borrowing fyDai. The achievable 
amount of leverage increases the closer the fyDai series is to maturity and the 
lower the interest rate achieved when selling the fyDai.
