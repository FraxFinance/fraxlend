import { ethers } from 'ethers';
import pLimit from 'p-limit';
import { config } from 'dotenv';
import { fraxlendPairDeployerAbi } from './abis/FraxlendPairDeployer.mjs';
import { fraxlendPairHelperAbi } from './abis/FraxlendPairHelper.mjs';
import { fraxlendPairAbi } from './abis/FraxlendPair.mjs';

// FIRST THINGS FIRST
// 1. Setup alchemy account and get your API key, you will need an archival node
// 2. Put an .env file in the root folder of your workspace and add MAINNET_KEY=yourAPIKeyHere

// Load .env file items onto process.env
config();

const { utils } = ethers;

const FRAXLEND_DEPLOYER_ADDRESS = '0x5d6e79Bcf90140585CE88c7119b7E43CAaA67044';
const FRAXLEND_PAIR_HELPER_ADDRESS = '0x26fa88b783cE712a2Fa10E91296Caf3daAE0AB37';

const provider = new ethers.providers.AlchemyProvider('homestead', process.env.MAINNET_KEY);

const main = async () => {
  // Get list of pairs
  const fraxlendPairDeployer = new ethers.Contract(FRAXLEND_DEPLOYER_ADDRESS, fraxlendPairDeployerAbi, provider);
  const fraxlendPairAddresses = await fraxlendPairDeployer.getAllPairAddresses();

  const fraxlendPairsWithAddresses = await Promise.all(
    // For each pair, get a list of all unique borrowers
    fraxlendPairAddresses.map(async (pairAddress) => {
      const events = await provider.getLogs({
        address: pairAddress,
        topics: [utils.id('BorrowAsset(address,address,uint256,uint256)')],
        fromBlock: 15455335,
      });
      const uniqueBorrowers = Object.keys(
        events.reduce((acc, item) => {
          // addresses come back as full 32bytes, so we slice the last 40 items
          acc['0x' + item.topics[1].slice(26)] = true;
          return acc;
        }, {}),
      );
      return uniqueBorrowers;
    }),
  );
  
  // This will limit our API calls to 10 concurrent calls, each call looks up LTV then liquidates if possible
  const limiter = pLimit(10);
  const promises = [];
  const fraxlendPairHelper = new ethers.Contract(FRAXLEND_PAIR_HELPER_ADDRESS, fraxlendPairHelperAbi, provider);

  fraxlendPairAddresses.forEach(async (pairAddress, index) => {
    const exchangeRate = await fraxlendPairHelper.previewUpdateExchangeRate(pairAddress);
    const [, , totalBorrowAmount, totalBorrowShares] = await fraxlendPairHelper.getPairAccounting(pairAddress);
    fraxlendPairsWithAddresses[index].forEach((borrowerAddress) => {
      promises.push(
        limiter(() =>
          checkPositionThenArb(
            fraxlendPairHelper,
            pairAddress,
            borrowerAddress,
            exchangeRate,
            totalBorrowAmount,
            totalBorrowShares,
          ),
        ),
      );
    });
  });
};

const checkPositionThenArb = async (
  fraxlendPairHelper,
  pairAddress,
  borrowerAddress,
  exchangeRate,
  totalBorrowAmount,
  totalBorrowShares,
) => {
  // Get some user accounting information
  const [ , borrowShares, collateralBalance] = await fraxlendPairHelper.getUserSnapshot(pairAddress, borrowerAddress);

  if (collateralBalance == 0) {
    console.log('cant calculate LTV, collateralBalance is 0');
    return;
  }

  // Calculate LTV
  const userBorrowAmount = borrowShares.mul(totalBorrowAmount).div(totalBorrowShares);
  const userLTV = userBorrowAmount.mul(exchangeRate).div(BigInt(1e18)).mul(1e5).div(collateralBalance);
  if (userLTV.gt(75000)) { // a user with a current LTV > 75% is liquidatable
    const fraxlendPair = new ethers.Contract(pairAddress, fraxlendPairAbi, new ethers.Wallet(process.env.PRIVATE_KEY, provider));
    const blockInfo = await provider.getBlock(await provider.getBlockNumber());

    // This is unnecessary but I want to leave some liquidations for my fellow searchers
    if (borrowerAddress !== '0xdb3388e770f49a604e11f1a2084b39279492a61f') {
      const receipt = await fraxlendPair.liquidate(borrowShares, blockInfo.timestamp + 1000, borrowerAddress);
      console.log('file: bot.mjs ~ line 130 ~ receipt', receipt);
    }
  }
};
main();
