// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract Demo {
    //public откуда угодно
    //external из вне контракта
    //internal из самого контракта
    //private только из самого этого контракта (из контрактов, созданных на основе этого контракта - нельзя)

    //view
    //pure не может читать переменные состояния
    string message = "hello"; //хранится в блокчейне

    //call (view/pure)
    function getBalance() public view returns(uint balance) {
        balance = address(this).balance;
        //return balance;
    }

    function getMessage() external view returns(string memory) {
        return message;
    }

    //memory временная память - в объявлении функций только она!
    //storage постоянная

    function rate(uint amount) public pure returns(uint) {
        return amount * 3;
    }

    //transaction
    function setMessage(string memory newMessage) public {
        message = newMessage;
    }

    uint public balance;

    function pay() external payable {
        balance += msg.value;
    }

}