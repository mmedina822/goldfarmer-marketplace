// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Marketplace {
    struct Domain {
        address owner;
        uint256 price; // Price in wei
        bool isForSale;
    }

    mapping(string => Domain) public domains; // Map domain name to Domain struct

    event DomainListed(string domainName, uint256 price, address indexed owner);
    event DomainSold(string domainName, address indexed buyer, uint256 price);

    // Function to list a domain for sale
    function listDomain(string memory domainName, uint256 price) public {
        require(price > 0, "Price must be greater than 0");
        require(domains[domainName].owner == address(0) || domains[domainName].owner == msg.sender, "Domain is already owned by someone else");

        // Set the domain details in the mapping
        domains[domainName] = Domain({
            owner: msg.sender,
            price: price,
            isForSale: true
        });

        emit DomainListed(domainName, price, msg.sender);
    }

    // Function to buy a domain
    function buyDomain(string memory domainName) public payable {
        Domain memory domain = domains[domainName];
        
        require(domain.isForSale, "Domain is not for sale");
        require(msg.value >= domain.price, "Insufficient funds to buy domain");

        // Transfer funds to the current owner
        payable(domain.owner).transfer(msg.value);

        // Update the owner and set the domain as not for sale
        domains[domainName].owner = msg.sender;
        domains[domainName].isForSale = false;

        emit DomainSold(domainName, msg.sender, domain.price);
    }

    // Function to change the price of a domain if it's already listed for sale
    function changeDomainPrice(string memory domainName, uint256 newPrice) public {
        Domain storage domain = domains[domainName];
        
        require(domain.isForSale, "Domain is not for sale");
        require(domain.owner == msg.sender, "Only the owner can change the price");

        domain.price = newPrice;
    }

    // Function to remove a domain from sale (only the owner can remove it)
    function removeDomainFromSale(string memory domainName) public {
        Domain storage domain = domains[domainName];
        
        require(domain.isForSale, "Domain is not for sale");
        require(domain.owner == msg.sender, "Only the owner can remove the domain from sale");

        domain.isForSale = false;
    }

    // Optional: Function to view the owner of a domain (for convenience)
    function getDomainOwner(string memory domainName) public view returns (address) {
        return domains[domainName].owner;
    }

    constructor() {
        // Optional initialization (e.g., setting up an initial list of domains if needed)
    }
}

