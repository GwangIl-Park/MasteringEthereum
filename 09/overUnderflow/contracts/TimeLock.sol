// SPDX-License-Identifier: MIT
pragma solidity ^0.7.3;

contract TimeLock {
    mapping (address => uint) public balances;
    mapping (address => uint) public lockTime;
    
    function deposit() public payable {
        balances[msg.sender] += msg.value;
        lockTime[msg.sender] = block.timestamp + 1 weeks;
    }

    function increaseLockTime(uint _secondsToIncrease) public {
        lockTime[msg.sender] += _secondsToIncrease;
    }

    function withdraw() public {
        require(balances[msg.sender]>0);
        require(block.timestamp > lockTime[msg.sender]);
        balances[msg.sender] = 0;
        msg.sender.transfer(balances[msg.sender]);
    }
}