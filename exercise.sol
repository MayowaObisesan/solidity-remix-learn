// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;


contract Exercise {
    uint public immutable age;
    string public location;
    string private fullName;
    string public firstName = "Mayowaaaabbbb";
    string public lastName = " Obisesan";
    string private constant userName = "Blessed";
    string public skinColor = "chocolate";

    uint num;

    constructor() {
        location = "Lagos";
        age = 10;
    }

    function getUsername() private pure returns (string memory) {
        return userName;
    }

    function getFullName() public returns (string memory) {
        fullName = string.concat(firstName, lastName);
        return fullName;
    }

    // You need to send a trnasaction to write to a state variable
    function set(uint _num) public {
        num = _num;
    }

    // You can read from a state variable without sending a transaction
    function get() public view returns (uint) {
        return num;
    }
}

contract ExerciseChild is Exercise {
    Exercise private childContract;

    constructor() {
        childContract = new Exercise();
    }

    function getChildFullName() public returns (string memory) {
        return childContract.getFullName();
    }
}