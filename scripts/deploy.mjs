import hardhat from "hardhat";
const { ethers } = hardhat;

async function main() {
    const [deployer] = await ethers.getSigners();
    console.log("Deploying contracts with the account:", deployer.address);

const Marketplace = await ethers.getContractFactory("contracts/GoldfarmerMarketplace.sol:Marketplace");
    const marketplace = await Marketplace.deploy();

    console.log("Marketplace contract deployed to:", marketplace.address);
}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});

