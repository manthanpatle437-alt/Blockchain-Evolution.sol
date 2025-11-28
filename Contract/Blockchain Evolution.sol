// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @title Blockchain Evolution
 * @dev A simple smart contract to demonstrate blockchain  data storage and interaction.
 */
contract BlockchainEvolution {

    struct Record {
        uint id;
        string data;
        address creator;
        uint timestamp;
    }

    uint public recordCount = 0;
    mapping(uint => Record) public records;

    event RecordCreated(uint id, string data, address creator, uint timestamp);
    event RecordUpdated(uint id, string newData, uint timestamp);

    // ✅ Function 1: Create a new record
    function createRecord(string memory _data) public {
        recordCount++;
        records[recordCount] = Record(recordCount, _data, msg.sender, block.timestamp);
        emit RecordCreated(recordCount, _data, msg.sender, block.timestamp);
    }

    // ✅ Function 2: Update existing record data
    function updateRecord(uint _id, string memory _newData) public {
        require(_id > 0 && _id <= recordCount, "Record not found");
        require(msg.sender == records[_id].creator, "Not authorized to update");

        records[_id].data = _newData;
        records[_id].timestamp = block.timestamp;
        emit RecordUpdated(_id, _newData, block.timestamp);
    }

    // ✅ Function 3: Retrieve record details
    function getRecord(uint _id) public view returns (Record memory) {
        require(_id > 0 && _id <= recordCount, "Invalid record ID");
        return records[_id];
    }
}
