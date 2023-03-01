// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract Demo {
    //require принимает 2 аргумента, и первым является условное выражение
    //revert принимает 1 аргумент и этим аргументом выступает сообщение об ошибке
    //assert принимает 1 аргумент (усл выражение), текст ошибки указать нельзя
    address owner;

    event Paid(address indexed _from, uint _amount, uint _timestamp); //объявляем событие
    //если поле помечено как indexed, то по нему можно реализовывать поиск по журналу событий

    constructor() {
        owner = msg.sender;
    }

    function pay() external payable {
        emit Paid(msg.sender, msg.value, block.timestamp); //порождаем событие
        // в журнал событий (хранится вместе с блокчейном(не в самом)) добавится событие со всей информацией;
        // за хранения в журнале событий платится меньше, чем за хранение в блокчейне
    }

    modifier onlyOwner(address _to) { 
        //на модификатор ссылается функция withdraw при выполнении
        require(msg.sender == owner, "you are not an owner!");
        require(_to != address(0), "incorrect address!");
        _; //обозначает, что нужно выйти из модификатора и приступить к выполнению тела функции
        //require(..)
    }

    function withdraw(address payable _to) external onlyOwner(_to) {
        //assert(msg.sender != owner); //породит ошибку типа Paniс. Использовать с осторожностью
        //require(msg.sender == owner, "you are not an owner!");
        //if(msg.sender != owner) {
        //  revert("you are not an owner!");
        //} else{}
        _to.transfer(address(this).balance);
    }
}