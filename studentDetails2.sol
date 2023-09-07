// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract StudentDetails {
    address principal;
    address public contractDeployer;

    struct Student {
        string name;
        uint age;
        string gender;
    }

    modifier onlyOwner() {
        require(msg.sender == principal, "Must be principal");
        _;
    }

    uint id;

    mapping(uint => Student) _student;

    event Admitted(string _name, string _gender, uint _age, uint _id);

    constructor(address _principal) {
        principal = _principal;
        contractDeployer = msg.sender;
    }

    function admitStudent(string memory _name, string memory _gender, uint _age) external {
        id = id + 1;
        Student storage newStudent = _student[id];
        newStudent.name = _name;
        newStudent.age = _age;
        newStudent.gender = _gender;
        emit Admitted(_name, _gender, _age, id);
    }

    function expel(uint _id) external onlyOwner {
        delete _student[_id];
    }

    function getStudentDetail(uint _id) external view returns (Student memory _s) {
        _s = _student[_id];
    }
}