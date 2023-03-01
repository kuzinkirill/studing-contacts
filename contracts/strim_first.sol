// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract Kuzini {
    address public owner;
    mapping(address => uint) payments;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner { 
        require(owner == msg.sender, "not an owner!");
        _;
    }

    function pay() external payable {
        payments[msg.sender] = msg.value;
    }

    function take() external onlyOwner() {
        payable(owner).transfer(address(this).balance);
    }
}