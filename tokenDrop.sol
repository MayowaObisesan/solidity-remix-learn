// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;


// Create a contract called token where you will specify the name of the token, the total number of token 
// that can be in circulation and have an allowList for addresses that can get your token.


contract Token {
    string constant tokenName = "BToken";
    uint public token = 1000;
    address[] allowList;
    address owner = msg.sender;

    mapping(address => bool) isEligible;

    function setAddressLegible(address userAddress) public {
        require(isEligible[userAddress] == false, "Address already has received token");
        if (!isEligible[userAddress]) {
            allowList.push(userAddress);
            isEligible[userAddress] = true;
            token -= 1;
        }
    }

    function canGetToken() view public returns (bool) {
        // require(isEligible[owner] == true);
        return isEligible[owner];
    }
}