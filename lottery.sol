// SPDX-License-Identifier: MIT
pragma solidity 0.8.8;


contract lottery{


    address manager;
    address payable[] public player; 

    constructor(){
        manager=msg.sender;
    }

    receive() external payable { 

        require(msg.value >= 1 ether);
        player.push(payable(msg.sender));
    }

    function balance() public   view returns(uint){
        require(msg.sender==manager);
        return(address(this).balance);
    }

    function random() public view returns(uint)
    {
        return uint(keccak256(abi.encodePacked(block.difficulty,block.timestamp,player.length)));
    }
    function winner() public  
    {
        uint r=random();
        uint index=r%player.length;

        address payable _winner;
        _winner=player[index];

        _winner.transfer(balance());

        player=new address payable[](0);
        
        
    }



}