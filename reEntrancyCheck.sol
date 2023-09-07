// SPDX-License-Identifier: MIT

pragma solidity ^0.8.2;


contract ReEntrancyCheck {
    bool public locked;
    uint x;

    // Modifier can be called before and / or after a function.
    // This modifier prevents a function from being called while 
    // it is still executing.
    modifier noReentrancy() {
        require(!locked, "No reentrancy");

        locked = true;
        _;
        locked = false;
    }

    function decrement(uint i) public noReentrancy {
        x -= i;

        if (i > 1) {
            decrement(i - 1);
        }
    }
}