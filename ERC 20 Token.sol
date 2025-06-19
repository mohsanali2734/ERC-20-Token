// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
contract MYTOKEN{
    string public name = "MyToken";
    string public symbol = "MYT";
    uint public decimal=18 ;
    uint public totalsupply;
    mapping(address=>uint) public balanceof;
    mapping (address=>mapping(address=>uint)) public allowence;
    event Transfer(address indexed from,address indexed to,uint value );
    event Approvel(address indexed owner,address indexed seplander,uint value);
    constructor(uint _initialSupply) {
    totalsupply = _initialSupply * 10 ** uint256(decimal);
    balanceof[msg.sender] = totalsupply;
    emit Transfer(address(0), msg.sender, totalsupply);
    }
    function transfer(address _to, uint _value) public returns (bool success){
    require(_to != address(0), "Cannot send to zero address");
    require(balanceof[msg.sender] >= _value, "Insufficient balance");
    balanceof[msg.sender] -= _value;
    balanceof[_to] += _value;
    emit Transfer(msg.sender, _to, _value);
    return true;
    }
    function approve(address _spender, uint256 _value) public returns (bool success) {
    require(_spender != address(0), "Cannot approve zero address");
    allowence[msg.sender][_spender] = _value;
    emit Approvel(msg.sender, _spender, _value);
    return true;
    }
    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) 
    {
    require(_from != address(0) && _to != address(0), "Invalid address");
    require(balanceof[_from] >= _value, "Insufficient balance from sender");
    require(allowence[_from][msg.sender] >= _value, "Not allowed to spend this amount");
    balanceof[_from] -= _value;
    balanceof[_to] += _value;
    allowence[_from][msg.sender] -= _value;
    emit Transfer(_from, _to, _value);
    return true;
    }
}

    


    



    
