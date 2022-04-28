//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

contract HelloWorld {

    string public greet;

    function getHelloWorld() public view returns(string memory)  {
        return greet;
    }

    function setHello(string memory _greet) public {
        greet = _greet;
        }

}
