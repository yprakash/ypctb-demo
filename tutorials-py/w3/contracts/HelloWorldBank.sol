// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

contract HelloWorldBank {
    address public owner;
    string private message;
    mapping (address => uint) private balances;

    constructor () {
        owner = msg.sender;
        message = "Hello";
    }

    // Create Deposit Event
    event DepositLog(address indexed sender, uint value, string message);

    function changeMessage (string memory _msg) public {
        message = _msg;
    }

    function getBalance() public view returns(uint) {
        return balances[msg.sender];
    }

    function isOwner() public view returns (bool) {
        return owner == msg.sender;
    }
    modifier onlyOwner() {
        require(isOwner(), "Not an Owner");
        _;
    }

    function deposit() public payable {
        require(balances[msg.sender] + msg.value > balances[msg.sender]);
        balances[msg.sender] += msg.value;
        emit DepositLog(msg.sender, msg.value, "Deposited ETH");
    }

    function withdraw(uint amount) public {
        require(amount <= balances[msg.sender], "Withdraw amount should be < balance");
        balances[msg.sender] -= amount;
        payable (msg.sender).transfer(amount);
    }

    function withdrawAll() public {
        payable (msg.sender).transfer(address(this).balance);
    }
}

