// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;


// Write a contract for handling student details where the details of a specific student can be updated or deleted by admin
// And anyone can query the details of each student.

contract StudentDatabase {
    struct Student {
        uint id;
        string name;
        uint age;
        uint level;
        string gender;
    }

    modifier isAdmin {
        require(admin == msg.sender, "Only admin can perform this operation");
        _;
    }

    uint public studentCount;
    address admin = msg.sender;
    mapping (uint => Student) public studentMapping;

    constructor() {
        
    }

    function createStudent(uint studentId, string memory _name, uint _age, uint _level, string memory _gender) public {
        require(admin == msg.sender, "Only admin can perform this operation");
        studentMapping[studentId] = Student(studentId, _name, _age, _level, _gender);
        studentCount++;
    }

    function deleteStudent(uint studentId) public {
        require(admin == msg.sender, "Only admin can perform this operation");
        delete studentMapping[studentId];
        studentCount--;
    }

    function updateStudent(uint studentId, string memory _name, uint _age, uint _level, string memory _gender) public {
        require(admin == msg.sender, "Only admin can perform this operation");
        Student storage student = studentMapping[studentId];
        student.name = _name;
        student.age = _age;
        student.gender = _gender;
        student.level = _level;
    }

    function updateStudentName(uint studentId, string memory _name) public {
        require(admin == msg.sender, "Only admin can perform this operation");
        // Student storage student = studentMapping[studentId];
        // student.name = _name;
        studentMapping[studentId].name = _name;
    }

    function updateStudentAge(uint studentId, uint _age) public {
        require(admin == msg.sender, "Only admin can perform this operation");
        studentMapping[studentId].age = _age;
    }

    function updateStudentLevel(uint studentId, uint _level) public {
        require(admin == msg.sender, "Only admin can perform this operation");
        studentMapping[studentId].level = _level;
    }

    function updateStudentGender(uint studentId, string memory _gender) public {
        require(admin == msg.sender, "Only admin can perform this operation");
        studentMapping[studentId].gender = _gender;
    }
} 