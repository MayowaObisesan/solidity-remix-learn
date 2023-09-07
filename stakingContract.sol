// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

interface IStakingToken {
    function buyToken() external payable;
    function transferFrom(address from, address to, uint256 value) external returns (bool);
    function balanceOf(address owner) external returns (uint);
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
        require(token.balanceOf(msg.sender) > 0, "Balance cannot be zero");
        // Once allowed, proceed to save the user and the staked amount.
        token.transferFrom(msg.sender, address(this), amount);
        
        stakedBalance[msg.sender] += amount;
        stakedAmount += amount;
    }
}
