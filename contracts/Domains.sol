//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import { StringUtils } from "./libraries/StringUtils.sol";
import  'hardhat/console.sol';

contract Domains{

    string public tld;

    mapping (string => address) public domains;

    mapping (string => string) public records;

    constructor(string memory _tld) payable {
        tld = _tld;
        console.log("This is the universal TLD!");
    }

    function price (string memory name) public pure returns(uint) {
        uint len = StringUtils.strlen(name);
        require (len >0);
        if (len == 3) {
            return 5 * 10**17;
        } else if (len == 4) {
            return 3 * 10**17;
        }
        else {
            return 1 * 10**17;
        }
        }
    

    function register(string calldata name) public payable{

        require (domains[name] == address(0));

        uint _price = price(name);

        //Check if matic is paid in tranasction

        require (msg.value >= _price, "Not enough fees");
        
        domains[name] = msg.sender;
        

    }

    function getAddress (string calldata name) public view returns (address) {
        return domains[name];
    }

    function setRecord(string calldata name, string calldata record) public {
        require (domains[name] == msg.sender);
        records[name] = record;
    }

    function getRecord(string calldata name) public view returns (string memory) {
        return records[name];
    }
}
