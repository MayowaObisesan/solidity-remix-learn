// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.20;

/**
 * - A multisig wallet
 * - Contract that should accept ether
 * - Array of signatories
 * - Approving transaction
 * - Mapping of address to bool for valid admins
 * - Mapping of uint to address to bool to track approval of each admin on each transaction
 * - Transaction detail
 */

contract MultiSig {
    uint constant MINIMUM = 3;
    uint transactionId;
    address[] Admins;

    struct Transaction {
        address spender;
        uint amount;
        uint numberOfApproval;
        bool isActive;
    }
    mapping(address => bool) isAdmin;
    mapping(uint => Transaction) transaction;
    mapping(uint => mapping(address => bool)) hasApproved;

    error InvalidAddress(uint position);
    error InvalidAdminCount(uint number);
    error Duplicate(address _addr);

    event Create(address owner, address spender, uint amount);

    fallback() external payable {}

    receive() external payable {}

    modifier onlyAdmin() {
        require(isAdmin[msg.sender], "Not a valid admin");
        _;
    }

    constructor(address[] memory _admins) payable {
        if (_admins.length < MINIMUM) {
            revert InvalidAdminCount(MINIMUM);
        }
        for (uint i = 0; i < _admins.length; i++) {
            if (_admins[i] == address(0)) {
                revert InvalidAddress(i + 1);
            }
            if (isAdmin[_admins[i]]) {
                revert Duplicate(_admins[i]);
            }
            isAdmin[_admins[i]] = true;
        }
        Admins = _admins;
    }

    function createTransaction(
        address _spender,
        uint _amount
    ) external onlyAdmin {
        transactionId++;
        Transaction storage _transaction = transaction[transactionId];
        _transaction.amount = _amount;
        _transaction.spender = _spender;
        _transaction.isActive = true;

        emit Create(msg.sender, _spender, _amount);
        approveTransaction(transactionId);
    }

    function approveTransaction(uint _id) public onlyAdmin {
        require(
            !hasApproved[_id][msg.sender],
            "You have already approved this transaction"
        );
        hasApproved[_id][msg.sender] = true;

        Transaction storage _transaction = transaction[_id];
        _transaction.numberOfApproval += 1;

        if (_transaction.numberOfApproval >= calculateMinumumCount()) {
            sendTransaction(_id);
        }
    }

    function calculateMinumumCount() public view returns (uint) {
        return (70 * Admins.length) / 100;
    }

    function sendTransaction(uint _id) internal {
        Transaction storage _transaction = transaction[_id];
        payable(_transaction.spender).transfer(_transaction.amount);
        _transaction.isActive = false;
    }

    function getTransaction(
        uint id
    ) external view returns (Transaction memory) {
        return transaction[id];
    }
}
