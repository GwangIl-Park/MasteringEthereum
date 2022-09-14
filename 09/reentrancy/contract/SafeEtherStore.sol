// SPDX-License-Identifier: MIT
pragma solidity ^0.7.3;

contract EtherStore {
  bool reentrancyMtx = false;
  uint256 public withdrawalLimit = 1 ether;
  mapping(address => uint256) public lastWithdrawalTime;
  mapping(address => uint256) public balances;

  function depositFunds() public payable {
    balances[msg.sender] += msg.value;
  }

  function withdrawFunds(uint256 _weiToWithdraw) public {
    require(!reentrancyMtx);
    require(_weiToWithdraw <= balances[msg.sender]);
    require(_weiToWithdraw <= withdrawalLimit);
    require(block.timestamp <= lastWithdrawalTime[msg.sender] + 1 weeks);
		balances[msg.sender]-=_weiToWithdraw;
    lastWithdrawalTime[msg.sender]=block.timestamp;
    reentrancyMtx = true;
    msg.sender.transfer(_weiToWithdraw);
    reentrancyMtx = false;
  }
}