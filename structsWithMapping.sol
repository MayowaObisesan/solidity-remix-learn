// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

// In smart contract, wrong data is as good as no data.

contract structsWithMapping {
    constructor() {}

    struct Web3 {
        address[] walletAddress;
    }

    struct Person {
        string firstName;
        string lastName;
        string userName;
        mapping(string => address) web3Data;
    }

    // Person person = Person("", "", "", {});

    function setProfile() external {
        // web3Data memory web3data = Person[]
    }
}