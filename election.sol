pragma solidity ^0.4.0;

contract Election{
    
    struct Candidate{
        string name;
        uint voteCount;
    }
    
    struct Voter{
        bool voted;
        uint voteIndex;
        uint weight;
    }
    
    // owner can authorize voters
    address public owner;
    string public name;
    //virtually initialized s.t. every possible key exists and is mapped to byte representation of all zeros (i.e. default values)
    mapping(address=>Voter) public voters;
    Candidate[] public candidates;
    uint public auctionEnd;
    event ElectionResult(string name, uint voteCount);
    
    function Election(string electionName, uint electionInMinutes, string candidate1, string candidate2){
        owner = msg.sender;
        name = electionName;
        //unix created timestamp of current block's creation time, not actual current time
        auctionEnd = now + (electionInMinutes * 1 minutes);
        
        candidates.push(Candidate(candidate1, 0));
        candidates.push(Candidate(candidate2, 0));
        
    }
    
    function authorize(address voter){
        require(msg.sender == owner);
        require(!voters[voter].voted);
        voters[voter].weight = 1;
    }
    
    function vote(uint _voteIndex){
        //election has not ended
        require(now<auctionEnd);
        require(!voters[msg.sender].voted);
        
        voters[msg.sender].voted = true;
        voters[msg.sender].voteIndex = _voteIndex;
        
        candidates[_voteIndex].voteCount += voters[msg.sender].weight;
    }
    
    function end(){
        require(msg.sender == owner);
        require(now>=auctionEnd);
        
        for(uint i=0; i<candidates.length; i++){
            ElectionResult(candidates[i].name, candidates[i].voteCount);
        }
    }
}