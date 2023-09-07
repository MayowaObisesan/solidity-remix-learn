// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import {ERC20, IERC20} from "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol";


interface IRewardToken is IERC20 {}

contract RewardToken is ERC20 {
    uint256 perToken = 0.3 ether;
    uint256 precision = 1e20;

    constructor(string memory name_, string memory symbol_)
        ERC20(name_, symbol_)
    {
        _mint(msg.sender, 1_000_000 ether);
    }
}
