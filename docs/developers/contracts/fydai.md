# Fixed Yield DAI

[Code](https://github.com/yieldprotocol/fyDai/blob/master/contracts/FYDai.sol)

Each FYDai contract provides a series of fyDai, an ERC20-compliant fyToken redeemable for Dai. 

Features:
- Each fyDai contract has a specific maturity time. 
- One fyDai is worth one Dai at maturity.
- At or after maturity, the fyDai can be triggered to `mature`, which records the 
current Stability Fee (`rate`) and Dai Savings Rate (`chi`) from MakerDAO and enables 
redemption. fyDai tracks the MakerDAO stability fee accumulator growth since maturity. 
    - The Stability Fee growth since maturity can be retrieved calling `rateGrowth`. 
    - The Dai Savings Rate growth since maturity can be retrieved calling `chiGrowth`. 
    - The value returned by `chiGrowth` is never higher than `rateGrowth`.
- To `redeem` a fyDai means burning it, and the contract will retrieve Dai from Treasury equal to one Dai times the growth in chi since maturity.
- Minting and burning of fyDai is restricted to orchestrated contracts.
- FYDai allow flash-minting, which take as parameters the amount of fyDai to `mint` and a bytes `data` variable that will be returned to the caller, so that reacting to the flash mint is possible.
