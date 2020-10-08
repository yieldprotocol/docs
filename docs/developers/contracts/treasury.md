# Treasury

Single interface for managing collateral and talking to Maker

Treasury manages asset transfers with users through all contracts in the Yield Protocol.

Treasury manages asset transfers with external contracts such as Chai and MakerDAO. The `debt()` function returns the debt of the Yield Protocol towards MakerDAO, in Dai terms. The `savings()` function returns the Chai holdings of the Yield Protocol. Only one of `debt()` and `savings()` is greater than zero at the same time.

Treasury is a _stateless_ contract, in the sense that has no state variables of its own. It only acts as a bridge between the other Yield Protocol contracts, MakerDAO vaults and Chai contract. By using the treasury address is the asset-holding address of the Yield Protocol in all external contracts.

Treasury will ensure that all Weth is always stored as collateral in MakerDAO.

Treasury will use all Dai to pay off system debt in MakerDAO first, and if there is no system debt the surplus Dai will be wrapped as Chai.

When requested to provide Dai, Treasury will first use any Chai it holds. If there isn't enough Chai, it will borrow Dai from MakerDAO.

Treasury doesn't have any transactional functions available for regular users.

All transactional methods are available only for orchestrated contracts. No contracts can be orchestrated after deployment, once ownership is renounced.