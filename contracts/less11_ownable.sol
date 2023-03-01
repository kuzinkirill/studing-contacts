// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract Ownable {
    address public owner;
        
    //constructor(address ownerOverride) {
    //если address ownerOverride равен нулевому, то владелец - msg.sender, иначе - ownerOverride
    //    owner = ownerOverride == address(0) ? msg.sender : ownerOverride;
    //}

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner { 
        require(owner == msg.sender, "not an owner!");
        _;
    }
    function withdraw(address payable _to) public virtual onlyOwner {
        payable(owner).transfer(address(this).balance);
    } //virtual говорит о том, что данную функцию можно переопределить ниже по иерархии (в потомке)
}
