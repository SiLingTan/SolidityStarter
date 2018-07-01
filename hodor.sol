// Uses pragma directive, to tell compiler that this is written for 
// Solidity compiler of equal than or greater than 0.4.0
pragma solidity ^0.4.0;

/*
    Simple smart contract that returns a greeting
*/

// Declare our smart contract
contract Hodor{
    
    //Address of creator account
    address creator;
    string greeting;

    //Constructor - only invoked once when the contract is first deployed to the Ethereum blockchain
    function Hodor(string _greeting) {
        greeting = _greeting;
        //message is a global variable 
        creator = msg.sender; //address of account sending message.
    }

    //constant: to say that it does not modify contract state and doesnt make any rights to the blockchain
    function greet() constant returns (string) {
        return greeting;
    }

    function setGreeting(string _greeting) {
        greeting = _greeting;
    }
}