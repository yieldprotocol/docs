# Fixed Yield DAI

fyDai is an ERC20-compliant fyToken targeting Chai.

Each fyDai contract has a specific maturity time. One fyDai is worth one Chai at or after maturity time.

At or after maturity, the fyDai can be triggered to `mature`, which records the current `rate` and `chi` from MakerDAO and enables redemption.

fyDai tracks the MakerDAO stability fee accumulator growth since maturity. This can be retrieved calling `rateGrowth`. fyDai tracks the MakerDAO DSR accumulator growth since maturity. This can be retrieved calling `chiGrowth`. The value returned by `chiGrowth` is never higher than `rateGrowth`.

To `redeem` a fyDai means burning it, and the contract will retrieve Dai from Treasury equal to one Dai times the growth in chi since maturity.

Minting and burning of fyDai is restricted to orchestrated contracts.

FYDai allow flash-minting, which take as parameters the amount of fyDai to `mint` and a bytes `data` variable that will be returned to the caller, so that reacting to the flash mint is possible.