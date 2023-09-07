// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

interface IStandardToken {
    function transferFrom(address from, address to, uint256 value) external returns (bool);
    function transfer(address to, uint256 value) external returns (bool);
    function balanceOf(address _owner) external view returns (uint256 balance);
    function withdrawEther() external;
}