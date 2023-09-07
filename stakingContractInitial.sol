// // SPDX-License-Identifier: MIT
// pragma solidity ^0.8.2;

// interface IStakingToken {
//     function buyToken() external payable;
//     function transferFrom(address from, address to, uint256 value) external returns (bool);
// }

// contract Staker {
//     IStakingToken token;
//     mapping(address => uint256) public stakedBalance;
//     uint public stakedAmount;

//     constructor(address contractAddress) {
//         token = IStakingToken(contractAddress);
//     }

//     function stakeAmount(uint256 amount) external payable {
//         // Once allowed, proceed to save the user and the staked amount.
//         token.transferFrom(msg.sender, address(this), amount);
//         stakedBalance[msg.sender] += amount;
//         stakedAmount += amount;
//     }
// }


pragma solidity ^0.8.2;

interface IStakingToken {
    function buyToken() external payable;
    function transferFrom(address from, address to, uint256 value) external returns (bool);
}

contract Staker {
    mapping(address => uint256) public stakedBalance;
    uint public stakedAmount;
    address immutable public tokenAddress;

    constructor(address contractAddress) {
        tokenAddress = contractAddress;
    }

    function stakeAmount(uint256 amount) external payable {
        IStakingToken token = IStakingToken(tokenAddress);
        // Once allowed, proceed to save the user and the staked amount.
        token.transferFrom(msg.sender, address(this), amount);
        stakedBalance[msg.sender] += amount;
        stakedAmount += amount;
    }
}
