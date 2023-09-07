// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;


interface IAbt {
    function getName() external view returns (string memory);

    function balanceOf() external pure returns (uint);
}

abstract contract Abt {
    string name = "Mayowa";

    function getName() external view returns (string memory) {
        return name;
    }

    function balanceOf() external pure returns (uint) {
        return 5;
    }

    function checkThis() external virtual;
}


contract AbtChild is Abt {
    string country = "Nigeria";

    Abt child;

    function getUserName() external view returns (string memory) {
        return child.getName();
    }

    function getUserCountry() external view returns (string memory) {
        return country;
    }

    function checkThis() external override {}
}