// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;


import {ERC20} from "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol";


contract StandardToken is ERC20 {
    uint perToken = 0.3 ether;
    uint precision = 1e20;

    constructor(string memory name_, string memory symbol_) ERC20(name_, symbol_) {
        _mint(msg.sender, 1_000_000 ether);
    }

    function decimals() public pure override returns (uint8) {
        return 8;
    }

    function buyToken() external payable {
        // require(amount != 0, "Cannot send 0 ether");
        uint amount = (msg.value * exchange()) / precision;
        // this.transfer(msg.sender, amount);
        _transfer(address(this), msg.sender, amount);
    }

    function exchange() public view returns (uint tokenValue) {
        uint _prec = 1000e8 * precision;
        tokenValue = (_prec / perToken);
    }

    function returnBalance() external view returns(uint etherBalance, uint tokenBalance) {
        // return the token balance and the ether balance
        etherBalance = address(this).balance;
        tokenBalance = balanceOf(address(this));
    }

    function withdrawEther() external {
        // withdraw all the balance of the msg.sender
        // payable(msg.sender).transfer(address(this).balance);

        // The call function returns a tuple.
        // (bool - returns if the call is successful or not, )
        (bool success,) = payable(msg.sender).call{value: address(this).balance}("");
        require(success, "transferFailed");
    }

    function validateOwner() internal {}

    // Assignment: We've built a token that allows one to 
    // Create a staking contract, that allows users to use the token to stake.
    // Buy the token before staking the contract.
    // Deploy it to testnet
    // Allows one to stake a user's token
    // Write a function that allows you to stake the mentor's token.
    // Get the amount to stake.
    // The staking contract calls transferFrom
    // address tokenAddress = 0x8Bc4b37aff83FdA8a74d2b5732437037B801183e;
}