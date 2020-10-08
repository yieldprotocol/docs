# Controller

Manage your collateral and take loans.

The Controller manages collateral and debt levels for all users, and it is a major user entry point for the Yield protocol. Weth and Chai are supported as collateral types, and many functions will require as the first parameter to specify "CHAI" or "ETH-A" encoded in a bytes32.

Controller relies on `Treasury` for all Dai, Chai and Weth transfers. Controller never holds any assets. Users never interact with the Treasury directly.

Controller integrates with a number of `FYDai` contracts decided upon deployment. These can be found in the `series` variable. The `seriesIterator` variable can be used to retrieve all `series`.

Controller allows users to `post` and `withdraw` Chai and Weth collateral. The assets are managed by the `Treasury`, and the `Controller` records them in the `posted` variable. Any transactions resulting in a user weth collateral below `DUST` are reverted.

Controller allows users to `borrow` fyDai against their Chai and Weth collateral. This will result in the Controller minting fyDai from the appropriate `series` into the appropriate wallet. Debt is recorded in fyDai terms, by collateral, by series, at `debtFYDai`. Matuer fyDai can be borrowed normally.

The `powerOf` function returns the borrowing power of an user in Dai terms. `locked` returns the amount of collateral already used in borrowing operations.

Controller allows to query the debt of an user in Dai terms, using `debtDai`. Before maturity 1 fyDai equals 1 Dai but after maturity the fyDai increases in value with MakerDAO's `vat.ilks("ETH-A").rate`. The `inDai` and `inFYDai` functions can be used to convert values from Dai to fyDai terms and viceversa. The `totalDebtDai` function returns the debt of an user, in Dai, aggregated across all series. The aggregated debt in fyDai must be computed by an external function, if needed.

Controller allows users to repay their fyDai debt with fyDai or with Dai. Repaying debt results in the Controller burning fyDai of the appropriate `series` from the appropriate wallet.

Users can delegate the control of their accounts in Controllers to any address using `controller.addDelegate(delegate.address)`. This feature is central to the core/periphery division and can be used by anyone to build proxies that interact safely with the user records in the controller.

All user-facing functions have `from` and `to` parameters, which combined with the delegation feature allow the functions in the Controller to be composed, avoiding intermediary asset transactions.

Controller allows orchestrated contracts to erase any amount of debt or collateral for an user. This is to be used during liquidations or during unwind. Users can never use `erase` directly.