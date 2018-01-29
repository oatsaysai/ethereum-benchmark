pragma solidity ^0.4.17;

contract Benchmark {
  mapping (uint => string) _strings;

  event FinishWrite(  
    uint256 _stringID,
    string data
  );

  function writeData(uint _stringID, string data, uint shaTime) public {
    for (uint i = 0; i < shaTime; i++) {
      sha256(data);
    }
    _strings[_stringID] = data;
    FinishWrite(_stringID, data);
  }
}
