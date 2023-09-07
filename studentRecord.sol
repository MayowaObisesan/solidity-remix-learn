// SPDX-License-Identifier: GPL-3.0

/*
1. Create a student record contract that stores up to 4 details about a student in a struct
2. Assign the student details in a mapping such that given an address you can query the details of the student
*/

pragma solidity >=0.7.0 <0.9.0;


contract StudentRecord {
    enum Gender {
        MALE,
        FEMALE
    }

    struct Student {
        // address studentAddress;
        string name;
        uint age;
        Gender gender;
        string level;
    }

    // Student student;

    mapping (address => Student) public studentMapping;

    Student student;

    function setDetails(string memory _name, uint _age, Gender _gender, string memory _level) public {
        // studentMapping[msg.sender] = Student(_name, _age, _gender, _level);
        student.name = _name;
        if (keccak256(abi.encodePacked(_age)) == keccak256(abi.encodePacked(""))) {
            student.age = _age;
        }
        if (keccak256(abi.encodePacked(_gender)) == keccak256(abi.encodePacked(""))) {
            student.gender = _gender;
        }
        if (keccak256(abi.encodePacked(_level)) == keccak256(abi.encodePacked(""))) {
            student.level = _level;
        }
        // student.age = _age;
        // student.gender = _gender;
        // student.level = _level;
        studentMapping[msg.sender] = student;
    }

    function getDetails() public view returns (Student memory) {
        return studentMapping[msg.sender];
    }
}