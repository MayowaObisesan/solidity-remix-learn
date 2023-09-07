// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

contract Schools {
    enum SchoolType {
        Federal,
        State,
        Private
    }
    struct School {
        string name;
        SchoolType schoolType;
        Department dept;
    }
    struct Department {
        string _nameD;
        uint matric;
        mapping(uint => LecturerDetails) lecturers;
    }

    struct LecturerDetails {
        string nameL;
        string subject;
    }

    mapping(uint => School) _school;
    uint schoolCount = 1;

    function setSchool(string memory _nameS, SchoolType _type, string memory _dept, uint _matric, string memory _nameL, string memory _subject) external {
        School storage newSchool = _school[schoolCount];
        newSchool.name = _nameS;
        newSchool.schoolType = _type;
        newSchool.dept._nameD = _dept;
        newSchool.dept.matric = _matric;
        newSchool.dept.lecturers[1].nameL = _nameL;
        newSchool.dept.lecturers[1].subject = _subject;
        schoolCount++;
    }

    function returnSchool(uint id, uint countNumber) external view returns (string memory _subject) {
        School storage newSchool = _school[countNumber];
        _subject = newSchool.dept.lecturers[id].subject;
        return _subject;
    }
}