// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

interface IPerson {
    function getName() external view returns (string memory);

    function setName(string memory _name) external;

    function getAge() external view returns(uint);

    function setAge(uint _num) external;
}


contract Person is IPerson {
    function getName() public view returns (string memory) {}

    function setName(string memory _name) public {}

    function getAge() public view returns (uint) {}

    function setAge(uint _num) public {}
}