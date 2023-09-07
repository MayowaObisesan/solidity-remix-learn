// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;


contract EnumSample {
    enum Status {
        Pending,
        Shipped,
        Accepted,
        Rejected,
        Canceled
    }
    string[5] StatusArray = ["Pending", "Shipped", "Accepted", "Rejected", "Canceled"];

    Status status;

    function get() public view returns (Status status_, string memory type_) {
        return (status, StatusArray[uint(status)]);
    }

    // Update status by passing uint into input
    function setEnum(Status _status) public {
        status = _status;
    }

    // You can update to a specific enum like this
    function setToCancel() public {
        status = Status.Canceled;
    }

    // delete resets the enum to its first value, 0
    function resetEnum() public {
        delete status;
    }
}

// Come up with a scenario, that defines a Struct with a Struct. Inside the nested struct, define a mapping
// Come up with a contract using different idea