// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;


// A token that can be transfered from one person to the other
// The token should follow the ERC-20 standard
// - a name
// - a symbol
// - an initial supply
// - a total supply
// - a maximum supply
// - balance
// - ownerOf
// - allowance
// - minting
// - burning
// - event

// Initial supply - The token furst released to the public
// Total supply - The total supply of token in circulation at a particular time
// Maximum supply - The total number of token that can be in circulation.

contract BToken {
    string _name;
    string _symbol;
    uint8 constant DECIMAL = 18;
    uint _totalSupply;
    address _user = msg.sender;
    
    mapping(address => uint) _balance;

    // msg.sender (or owner) => spender => value
    mapping(address => mapping(address => uint)) _allowance;

    event Transfer(address from, address to, uint value);
    event Approve(address indexed _owner, address indexed _spender, uint _value);
    event Minted(address _to, uint _value);
    event Burnt(uint _value);

    constructor(string memory name_, string memory symbol_) {
        _name = name_;
        _symbol = symbol_;
    }

    function name() public view returns (string memory) {
        return _name;
    }

    function symbol() public view returns (string memory) {
        return _symbol;
    }

    function decimals() public pure returns (uint8) {
        return DECIMAL;
    }

    function totalSupply() public view returns (uint256) {
        return _totalSupply;
    }

    function balanceOf(address _owner) public view returns (uint256 balance) {
        return _balance[_owner];
    }

    function transfer(address _to, uint256 _value) public returns (bool success) {
        // Sanity check - not allowing users to waste your token
        require(_to != address(0), "Cannot transfer to Address zero");
        require(_value > 0, "Increase value");
        require(balanceOf(msg.sender) >= _value, "Insufficient funds");
        _balance[msg.sender] -= _value;
        _balance[_to] += _value;
        success = true;

        emit Transfer(msg.sender, _to, _value);
    }

    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) {
        require(_to != address(0), "Cannot transfer to Address zero");
        require(_value > 0, "Increase value");
        require(balanceOf(_from) >= _value, "Insufficient funds");
        require(allowance(_from, _to) <= _value, "Insufficient allowance");
        _balance[_from] -= _value;
        _balance[_to] += _value;
        success = true;
    }

    function approve(address _spender, uint256 _value) public returns (bool success) {
        _allowance[msg.sender][_spender] = _value;
        success = true;
        emit Approve(msg.sender, _spender, _value);
    }

    function allowance(address _owner, address _spender) public view returns (uint256 ) {
        return _allowance[_owner][_spender];
    }

    function mint(address _to, uint _value) external payable {
        // _value is the number of token to mint
        // Allow people to mint with 5 ether per token
        require(_to != address(0), "Cannot transfer to Address zero");

        uint actualValue = _value * 5 ether;
        require(msg.value == actualValue, "Insufficient funds");
        
        uint modRes;
        if (_value % 5 != 0) {
            modRes = (_value % 5);
        }
        uint div = _value / 5;
        uint tokenRes = div * 1 ether + modRes;

        _totalSupply += _value;
        _balance[_to] += tokenRes;

        emit Minted(_to, _value);
    }

    function withdraw(uint _value) external payable {
        // require(msg.sender == _user, "");
        // Check if the user has the balance to transfer on the contract
        // require(balanceOf(_user) >= _value, "Insufficient token balance");
        // require(msg.value >= _value, "Insufficient balance");
        // payable(msg.sender).transfer(_value);

        // msg.value is the amount of ether sent

        require(address(this).balance > 0, "Nothing to withdraw");
        require(address(this).balance > _value, "Insufficient balance");
        payable(address(this)).transfer(_value);
    }

    function burn(uint value, address _to) external {
        // require that msg.sender has the amount (i.e., value) to be burnt
        require(balanceOf(msg.sender) >= value, "Insufficient value");
        require(_to != msg.sender, "You cannot send to yourself");
        // Ensure that the msg.sender can only burn 90% of the token and send the remaining 10% of the unburnt token
        uint cut = (value * 90) / 100;
        _balance[_to] += (value - cut); // send the 10% first before removing the balance from the msg.sender's account
        _balance[msg.sender] -= value;
        _totalSupply -= cut;
        emit Burnt(value);
    }

    function userAddress() external view returns (address) {
		return msg.sender;
	}
}