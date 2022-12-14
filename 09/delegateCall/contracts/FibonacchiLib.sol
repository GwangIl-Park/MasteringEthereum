// SPDX-License-Identifier: MIT
pragma solidity ^0.7.3;

contract FibonacchiLib {
    uint public start;
    uint public calculatedFibNumber;

    function setStart(uint _start) public {
        start = _start;
    }

    function setFibonacci(uint n) public {
        calculatedFibNumber = fibonacci(n);
    }

    function fibonacci(uint n) internal returns (uint) {
        if(n==0) return start;
        else if (n==1) return start + 1;
        else return fibonacci(n-1) + fibonacci(n-2);
    }
}