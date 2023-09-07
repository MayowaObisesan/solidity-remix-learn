// SPDX-License-Identifier: GPL-3.0

/*
1. Create a student record contract that stores up to 4 details about a student in a struct
2. Assign the student details in a mapping such that given an address you can query the details of the student
*/

pragma solidity >=0.7.0 <0.9.0;

import "./studentDetails2.sol";

contract studentDetailsFactory {
    StudentDetails[] studentDetails;

    function createStudentDetails() external returns(StudentDetails newDetails) {
        newDetails = new StudentDetails(msg.sender);
        newDetails.admitStudent("Mayowa", "male", 7);
        newDetails.getStudentDetail(10);
        studentDetails.push(newDetails);
    }
}