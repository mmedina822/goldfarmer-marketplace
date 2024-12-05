require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config(); // Load environment variables from .env

module.exports = {
    solidity: "0.8.27",
    networks: {
        sepolia: {
            url: process.env.SEPOLIA_RPC_URL,
            accounts: [process.env.PRIVATE_KEY],
        },
        goerli: {
            url: process.env.GOERLI_RPC_URL, // Make sure GOERLI_RPC_URL is set in .env
            accounts: [process.env.PRIVATE_KEY], // Use the private key from .env
        },
    },
};

