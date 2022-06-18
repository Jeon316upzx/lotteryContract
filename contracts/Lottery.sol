// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;


contract Lottery {
     
     address public manager;
     address[] public players;

     constructor(){
       manager = msg.sender;
     }

     function enter() public payable{
        require(msg.value > 1 ether);
        players.push(msg.sender);
     }

     function getPlayers() public view returns(uint){
      return players.length;
     }

     function random() private view returns(uint){
        uint(keccak256(abi.encodePacked(block.difficulty, block.timestamp, players)));
     }

     function pickWinner() public onlyManager {
         uint index = random() % players.length;
         payable(players[index]).transfer(address(this).balance);
         players = new address[](0);
     }

     modifier onlyManager(){
        require(msg.sender == manager);
        _;

     }

}