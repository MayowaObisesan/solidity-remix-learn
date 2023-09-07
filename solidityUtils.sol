// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;


contract EtherUnits {
    uint public oneWei = 1 wei;
    bool public isOneWei = 1 wei == 1;
    
    uint public oneEther = 1 ether;
    bool public isOneEther = 1 ether == 1e18;
}


contract GasTries {}


contract Conditionals{
    function foo(uint x) public pure returns (uint) {
        if (x < 10) {
            return 0;
        } else if (x < 20) {
            return 1;
        } else {
            return 2;
        }
    }

    function tenary(uint _x) public pure returns (uint) {
        // if (_x < 10) {
        //     return 1;
        // } else {
        //     return 2;
        // }
        return _x < 10 ? 1 : 2;
    }
}


contract Loops {
    function forLoop() public pure {
        for (uint i = 0; i < 10; i++) {
            if (i == 3) {
                // Skip to the next iteration with continue
                continue;
            }
            if (i == 5) {
                // Exit loop with break
                break;
            }
        }
    }

    function whileLoop() public pure {
        // This function runs 10 times
        uint j; // same as uint j = 0;
        while (j < 10) {
            j++;
        }
    }
}


contract Checker {
    function testRequire(uint _i) public pure {
        // require is used to 
        require(_i > 10, "Input must be greater than 10");
    }

    function testRevert(uint _i) public pure {
        // Revert is useful when the condition to check is complex.
        // This code does the same exact same thing as the example above
        if (_i <= 10) {
            revert("Input must be greater than 10");
        }
    }

    uint public num;

    function testAssert() public view {
        // Assert should only be used to test for internal errors,
        // and to 
    }
}


contract EnumsTries {}


contract Owner {
    address owner;
    constructor() {
        owner == msg.sender;
    }
    modifier isAdmin {
        require(owner == msg.sender, "Only owner can perform this operation");
        _;
    }
}