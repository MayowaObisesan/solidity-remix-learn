// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

contract Checker {
    uint8 public one = 250;

    function add(uint256 breaker) external returns (uint8) {
        one += uint8(breaker);
        return one;
    }
}