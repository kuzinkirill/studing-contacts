// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract Op {
    //оптимизированный

    //uint demo
    
    mapping(address => uint) payments; 
    function pay() external payable {
        require(msg.sender != address(0), "zero address");
        payments[msg.sender] = msg.value;
    }
}

contract Un {
    //неотпимизированный

    //uint demo = 0;

    mapping(address => uint) payments;
    function pay() external payable {
        address _from = msg.sender; //избегать создавания временных переменных, когда в этом нет необходимости
        require(_from != address(0), "zero address");
        payments[_from] = msg.value;
    }
}

// большая часть инфы с урока в эверноте