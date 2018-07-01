pragma solidity ^0.4.0;

/*
Currency that can only be issued by its creator and transferred to anyone
*/
contract DragonStone {
    //address of account creating the contract
    //public keyword automatically generates a fn to allow other contracts to access current fn value (using creator())
    address public creator;
    //keeps track who owns how many dragonstones. others can query balance of an account (using balances(address))
    mapping (address => uint) public balances;

    // event that notifies when a transfer has completed
    // event keyword is to say something of interest has happened. They are fired from within 
    // fns and can be listened to from the ServerSide or Frontend. The listener would get 
    // the input parameters values. 
    event Delivered(address from, address to, uint amount);

    function DragonStone() {
        creator = msg.sender;
    }

    // Only creator can invoke this function to create currency
    function create(address receiver, uint amount) {
        if (msg.sender != creator) throw;
        balances[receiver] += amount;
    }

    function transfer(address receiver, uint amount) {
        if (balances[msg.sender] < amount) throw;
        balances[msg.sender] -= amount;
        balances[receiver] += amount;
        // to inform listeners of the successful transfer
        Delivered(msg.sender, receiver, amount);
    }
}
