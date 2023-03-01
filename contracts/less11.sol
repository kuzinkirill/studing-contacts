// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

import "./less11_ownable.sol";

//развернуть абстрактный контракт нельзя, но наследовать можно
abstract contract Balances is Ownable {
    //означает, что данный контракт Balances наследует от Ownable, 
    //но сам по себе он является "частичным"
    //сделали мы его абстрактным, потому что не передали ему ownerOverride
    function getBalance() public view onlyOwner returns(uint) {
        return address(this).balance;  //узнаем адрес контракта
    }

    function withdraw(address payable _to) public override virtual onlyOwner {
        _to.transfer(getBalance()); //переводим средства с баланса контракта на аккаунт владельца
    }//нужно что-то придумать с ф-ией withdraw, так как в MyContract она следует разной от двух родителей
    // потому добавим virtual и ко второй, чтобы ее также можно было похже переопределить
    
}

//нужно что-то придумать с ф-ией withdraw, так как в MyContract она следует разной от двух родителей

//Наследование
//порядок ОЧЕНЬ ВАЖЕН, но в данном случае можно и просто:
//contract MyContract is Balances { //потому что Balances сам наследует Ownable
contract MyContract is Ownable, Balances {
    constructor(address _owner) {
        //переопределяем конструктор для родителя (меняем значение owner на новое)
        owner = _owner;
    }
    //нужно обязательно сказать, для каких контрактов я эту ф-ию переопределяю
    function withdraw(address payable _to) public override(Ownable, Balances) onlyOwner {
        //менять видимость нельзя, т.е. в функциях потомка не поменять public На private.

        //здесь можно выполнять проверки, добавлять функционал, после чего ссылаться на базовую версию функции

        //Balances.withdraw(_to); //то же самое, что в 38 строке (чтобы не дублировать код),
        //ЯВНО УКАЗАНО, на каком контракте вызывать функцию
        super.withdraw(_to); //Неявно. Super говорит о подъеме на 1 уровень вверх
    }
             
}

