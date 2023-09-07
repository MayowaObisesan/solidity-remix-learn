// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import {IStandardToken} from "./stakingContractImprovedInterface.sol";
import {IRewardToken} from "./rewardToken.sol";

contract stakingImproved {
    IStandardToken standardToken;
    // uint public constant rewardRatePerSecond = 0.0000001 ether;
    uint public constant rewardRatePerSecond = 100 wei;

    struct User {
        uint amountStaked;
        uint timeStaked;
        uint reward;
    }

    mapping (address => User) user;

    event Staked(uint amount, uint totalAmountStaked, uint time);
    event Withdraw(address sender, uint amount);
    event WithdrawReward(address sender, uint amount);

    // Allow users to stake standardToken
    constructor(address _standardToken) {
        // Ensure that only standardToken is staked
        standardToken = IStandardToken(_standardToken);
    }

    function stake(uint amount) external {
        require(amount > 0, "Amount must be greater than 0");
        uint balance = standardToken.balanceOf(msg.sender);
        require(balance >= amount, "ERC20 insufficient balance");
        bool status = standardToken.transferFrom(msg.sender, address(this), amount);
        require(status, "Transfer failed");
        User storage _user = user[msg.sender];

        _user.amountStaked += amount;
        _user.timeStaked = block.timestamp;
        _user.reward = calculateRewards();
        emit Staked(amount, _user.amountStaked, block.timestamp);
    }

    function getStaked(address who) public view returns (uint _staked) {
        User storage _user = user[who];
        _staked = _user.amountStaked;
    }

    function withdraw(uint amount) external {
        User storage _user = user[msg.sender];
        uint totalStaked = getStaked(msg.sender);
        require(totalStaked >= amount, "Insufficient staked amount");
        _user.amountStaked -= amount;

        standardToken.transfer(msg.sender, amount);

        emit Withdraw(msg.sender, amount);
    }

    function withdrawEther() external {
        standardToken.withdrawEther();
    }

    // A receive function should not contain any logic.
    receive() external payable {}

    // A fallback function can contain and run logic.
    fallback() external payable {}

    function calculateRewards() internal view returns (uint) {
        User storage _user = user[msg.sender];
        uint duration = block.timestamp - _user.timeStaked;

        // calculate the reward of the user by multiplying the amountStaked by the rewardRatePerSecond and the duration staked for.
        return _user.amountStaked * duration * rewardRatePerSecond;
    }

    function withdrawReward() external {
        // Initialize the rewardToken
        IRewardToken rewardToken = IRewardToken(msg.sender);
        require(address(rewardToken) != address(0), "Cannot distribute to address zero");
        
        // Get the user to send the Reward to.
        User storage _user = user[msg.sender];
        _user.reward = calculateRewards();

        require(rewardToken.balanceOf(address(this)) >= _user.reward, "Insufficient reward tokens");
        // Transfer the reward the user owns from his stake
        rewardToken.transfer(msg.sender, _user.reward);

        // Reset the reward field for the user and reset the timeStaked for the user
        _user.reward = 0;
        _user.timeStaked = block.timestamp;

        emit WithdrawReward(msg.sender, _user.reward);
    }

    function distributeReward(address rewardee) external {
        // Initialize the rewardToken
        IRewardToken rewardToken = IRewardToken(rewardee);
        require(address(rewardToken) != address(0), "Cannot distribute to address zero");
        
        // Get the user to send the Reward to.
        User storage _user = user[rewardee];
        _user.reward = calculateRewards();

        require(rewardToken.balanceOf(address(this)) >= _user.reward, "Insufficient reward tokens");
        // Transfer the reward the user owns from his stake
        rewardToken.transfer(rewardee, _user.reward);
    }
}