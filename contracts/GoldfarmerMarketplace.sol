// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Marketplace {
    struct Domain {
        address owner;
        uint256 price; // Price in wei
        bool isForSale;
    }

    mapping(string => Domain) public domains;

    event DomainListed(string domainName, uint256 price, address indexed owner);
    event DomainSold(string domainName, address indexed buyer, uint256 price);

    function listDomain(string memory domainName, uint256 price) public {
        require(price > 0, "Price must be greater than 0");
        require(domains[domainName].owner == address(0) || domains[domainName].owner == msg.sender, "Domain is already owned");

        domains[domainName] = Domain({
            owner: msg.sender,
            price: price,
            isForSale: true
        });

        emit DomainListed(domainName, price, msg.sender);
    }

    // Add closing braces or other missing functions here if incomplete.
}

