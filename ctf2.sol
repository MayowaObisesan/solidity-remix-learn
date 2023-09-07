// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

interface I_W_3_B_C_2 {
    struct User {
        address r;
        bytes12 s;
    }

    function get(bytes32 _POSITION) external view returns (User memory ur);

    function submitkey(bytes12 key) external;
}


// contract Soldier {
//     struct User {
//         address r;
//         bytes12 s;
//     }

//     constructor(address _addr) {
//         I_W_3_B_C_2 sold = I_W_3_B_C_2(_addr);
//     }

//     function get(bytes32 _POSITION) external view returns (User memory users) {
//         return users[_POSITION];
//     }

//     function submitkey(bytes12 key) external {
//         users[_POSITION] = User(msg.sender, key);
//     }
// }


// contract W3BC2Contract {
//     struct User {
//         address r;
//         bytes12 s;
//     }

//     mapping(bytes32 => User) public users;

//     function get(bytes32 _POSITION) external view returns (User memory ur) {
//         return users[_POSITION];
//     }

//     function submitKey(bytes32 _POSITION, bytes12 key) external {
//         users[_POSITION] = User(msg.sender, key);
//     }
// }

contract MyContract {
    I_W_3_B_C_2 private interfaceInstance;

    constructor(address _interfaceAddress) {
        interfaceInstance = I_W_3_B_C_2(_interfaceAddress);
    }

    function getUser(bytes32 _position) external view returns (address, bytes12) {
        I_W_3_B_C_2.User memory user = interfaceInstance.get(_position);
        return (user.r, user.s);
    }

    function submitKey(bytes12 _key) external {
        interfaceInstance.submitkey(_key);
    }
}