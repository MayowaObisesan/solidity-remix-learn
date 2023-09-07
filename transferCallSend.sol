// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

contract TransferSendCall{
    // Don't add payable to the function that sends ether, only add payable to a function that receives ether
    function transfer() public {}

    function viewEtherCalldata() public view returns (bytes memory k) {
        k = abi.encodeWithSelector(bytes4, arg);
    }
}