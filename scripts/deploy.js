const { ethers } = require("hardhat");

async function main() {
  // Get the deployer's account
  const [deployer] = await ethers.getSigners();
  console.log("Deploying contracts with the account:", deployer.address);

  // Get the contract factory for the Marketplace contract
  const MarketplaceFactory = await ethers.getContractFactory("contracts/Marketplace.sol:Marketplace");

  // Deploy the contract
  const marketplace = await MarketplaceFactory.deploy();

  // Wait for the contract to be deployed
  await marketplace.deployed();

  console.log("Marketplace contract deployed to:", marketplace.address);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});

