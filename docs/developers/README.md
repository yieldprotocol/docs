# Developer Documentation

The quickest place to get started is the fyDAI repository. Clone it and run the tests:

```bash
git clone https://github.com/yieldprotocol/fyDai/
yarn
yarn test
```

The Yield specification can be found [here](https://docs.google.com/document/d/1TSc63v0E9X_aqmAL5VeIM1GDpALsf6yHiq0wGpfnsns/edit?usp=sharing).

Yield Protocol is made up of the [core](contracts/core.md) contracts and the [periphery](contracts/periphery.md). 

The core contracts are responsible for the management of collateral and debt, issuing and redeeming 
fyDAI and interacting with MakerDAO's contracts, amoung other functions:
 - `Treasury` is the single point of contact of the Yield Protocol with MakerDAO contracts, including Chai, for the purpose of asset management. 
 - `FYDai` contracts are ERC20 contracts that provide tokens that are redeemable for Dai upon reaching a specific maturity. After maturity, the redemption value earns the Dai Savings Rate. 
 - `Controller` manages collateral and debt for all users, issuing fyDai tokens as debt is taken or burning them as it is repaid.
 - `Liquidations` allows to take over user accounts when they are undercollateralized, selling the colalteral to settle the outstanding debt
 - `Unwind`allows to redeem fyDai, settle debt, and settle ongoing auctions in the event of a MakerDAO shutdown.

The pool contracts allow Dai-fyDai trading.

The periphery contracts are responsible for providing convenience functions to the frontend.

Below you may see a high level graph of how the contracts interact with each other.

<figure class="image" align = "center">
  <img src="../assets/core-arch.png">
  <figcaption><i>The Yield protocol architecture</i></figcaption>
  <br>
</figure>


Actions in Yield are multi-step processes. In order to improve UX we also 
provide a stateless proxy contract in order to batch together complex calls. Future versions of the
YieldProxy will enable converting Maker vaults to Yield vaults (and vice versa).
Users are expected to interface with the protocol via these proxy contacts.

<figure class="image" align = "center">
  <img src="../assets/proxy-arch.png">
  <figcaption><i>The YieldProxy is the main entrypoint for users</i></figcaption>
  <br>
</figure>
