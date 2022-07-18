pragma solidity >=0.8.0 <0.9.0;

import "./AnonymousElection.sol";

contract AnonymousElectionCreator {
    // Who is the owner of this election creator?
    // instantiate the address of the owner of the election.
    address private owner;

    // create a mapping of the election name string to the election address.
    mapping(string => address) private nameToAddressMap;
    // create an array of strings of the names of elections.
    string[] private electionsList;

    // Create the constructor.
    constructor() {
        // TO DO: instantiate the "owner" as the msg.sender.
        owner = msg.sender;
        // TO DO: instantiate the election list.
    }


    // Write the function that creates the election:
    function createElection(string memory _electionName, string[] memory _candidates, address[] memory _voters, bytes memory _p, bytes memory _g) public returns(address) {
        // make sure that the _electionName is unique
        // nameToAddressMapuse the solidity require function to ensure the election name is unique. "Election name not unique. An election already exists with that name."
        require(nameToAddressMap[_electionName] == address(0), "Election name not unique. An election already exists with that name.");
        // nameToAddressMapuse the solidity require function to ensure "candidate list and voter list both need to have non-zero length, >1 candidate."
        require(_candidates.length > 1, "At least 2 candidates needed.");
        require(_voters.length > 0, "At least 1 voter needed.");

        // nameToAddressMapUsing a for loop, require none of the candidates are the empty string.
        for (uint256 i; i < _candidates.length; i++) {
            require(bytes(_candidates[i]).length > 0, "No candidate can be the empty string.");
        }

        // nameToAddressMapCreate a new election.
        AnonymousElection election = new AnonymousElection(_candidates, _voters, _p, _g, msg.sender, _electionName);

        // nameToAddressMapCreate a mapping between _electionName and election address.
        nameToAddressMap[_electionName] = address(election);

        // nameToAddressMapUse .push() to add name to electionsList
        electionsList.push(_electionName);

        // nameToAddressMapreturn the address of the election created
        return getElectionAddress(_electionName);
    }

    // return address of an election given the election's name
    function getElectionAddress(string memory _electionName) public view returns(address) {
        address electionAddress = nameToAddressMap[_electionName];
        // nameToAddressMapUsing the solidity require function, ensure that _electionName is a valid election.
        require(electionAddress != address(0), "Election is not valid.");
        // nameToAddressMapReturn the address of requested election.
        return electionAddress;
    }

    // return list of all election names created with this election creator
    function getAllElections() public view returns (string[] memory){
        return electionsList;
    }
}
