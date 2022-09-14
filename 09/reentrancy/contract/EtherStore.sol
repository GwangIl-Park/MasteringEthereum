// SPDX-License-Identifier: MIT
pragma solidity ^0.7.3;

contract EtherStore {
  uint256 public withdrawalLimit = 1 ether;
  mapping(address => uint256) public lastWithdrawalTime;
  mapping(address => uint256) public balances;

  function depositFunds() public payable {
    balances[msg.sender] += msg.value;
  }

  function withdrawFunds(uint256 _weiToWithdraw) public{
    require(_weiToWithdraw <= balances[msg.sender],"11");
    require(_weiToWithdraw <= withdrawalLimit,"22");
    require(block.timestamp <= lastWithdrawalTime[msg.sender] + 1 weeks);
    (bool success,) = msg.sender.call{value:_weiToWithdraw}("");
    require(success,"33");
    balances[msg.sender]-=_weiToWithdraw;
    lastWithdrawalTime[msg.sender]=block.timestamp;
  }
}