// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

contract StakingAI {
    address public tokenAddress;
    uint256 public constant rewardRatePerSecond = 0.1 ether;

    mapping(address => uint256) public balances;
    mapping(address => uint256) public depositTimestamps;
    mapping(address => uint256) public rewards;

    event Staked(uint amount, uint totalAmountStaked, uint time);

    function stake(uint256 amount) public {
        require(amount > 0, "Amount must be greater than 0");
        require(
            token.transferFrom(msg.sender, address(this), amount),
            "Transfer failed"
        );

        balances[msg.sender] += amount;
        depositTimestamps[msg.sender] = block.timestamp;
        rewards[msg.sender] = calculateRewards(msg.sender);

        emit Staked(msg.sender, amount);
    }

    function withdraw() public {
        uint256 amount = balances[msg.sender];
        require(amount > 0, "No balance to withdraw");

        balances[msg.sender] = 0;
        rewards[msg.sender] = 0;

        require(token.transfer(msg.sender, amount), "Transfer failed");

        emit Withdraw(msg.sender, amount);
    }

    function calculateRewards(address user) internal view returns (uint256) {
        uint256 depositTime = depositTimestamps[user];
        uint256 currentTime = block.timestamp;
        uint256 duration = currentTime - depositTime;

        return balances[user] * duration * rewardRatePerSecond;
    }
}
