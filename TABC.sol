pragma solidity ^0.8.0;
import "./string.sol";
contract ThrCred {
    using strings for *;
    uint public n_I;
    uint public t_I;
    uint public n_T;
    uint public t_T;
    uint public q;
    struct Reg {
        string reg;
        mapping (uint => string) cred;
    }
    struct ShareInfor {
        string id;
        string Data;
    }
    struct Token {
        string token;
        mapping (uint => ShareInfor) TiList;
        string id; 
    }

    address public pk;

    mapping (uint => address) public ipkList;
    mapping (uint => address) public tpkList;
    mapping (address => Reg) public regList;
    mapping (address => Token) public tokenList;
    mapping (uint => ShareInfor) public  QiList;
    string [] public revList;


    constructor() {
        pk = msg.sender;

    }


   function Create(uint _n_I, uint _t_I, uint _n_T, uint _t_T, uint _q) public{
        require(msg.sender == pk);
        n_I = _n_I;
        t_I = _t_I;
        n_T = _n_T;
        t_T = _t_T;
        q = _q;
    } 

    function AddIssuer(uint _i, address _ipk)public{
        require(msg.sender == pk);
        ipkList[_i]=_ipk;        
    } 

    function AddTracer(uint _i, address _tpk)public{
        require(msg.sender == pk);
        tpkList[_i]=_tpk;    
    } 

    function uploadReg(address _upk, string memory _reg) public {
        require(msg.sender == _upk);
        regList[_upk].reg = _reg;
        
    }
    
    function getReg(uint _i, address _ipk, address _upk) public view returns (string memory) {
        require(msg.sender == _ipk);
        require(ipkList[_i] == _ipk);
        return regList[_upk].reg;
    }

    function uploadCred(uint i, address _ipk, address _upk, string memory _cred) public {
        require(msg.sender == _ipk);
        require(ipkList[i] == _ipk);
        regList[_upk].cred[i] = _cred;
        
    }

    function getCred(address _upk, string memory tmpvalue) public view returns (string memory){
        require(msg.sender == _upk);
        string memory tmpstr;
        tmpvalue = "";
        uint i;
		for(i = 0; i < t_I; i ++)
		{
            tmpstr = regList[_upk].cred[i];
		    tmpvalue = tmpvalue.toSlice().concat(tmpstr.toSlice());

        }
        return tmpvalue;
    }

    function uploadToken(address _vpk, string memory _token) public {
        require(msg.sender == _vpk);
        tokenList[_vpk].token = _token;
    }

    function getToken(uint _i, address _tpk, address _vpk) public view returns (string memory){
        require(msg.sender == _tpk);
        require(tpkList[_i] == _tpk);
        return tokenList[_vpk].token;
    } 

    function uploadTi(uint _i, address _tpk, address _vpk, string memory _id, string memory _Ti) public {
        require(msg.sender == _tpk);
        require(tpkList[_i] == _tpk);
        tokenList[_vpk].TiList[_i].id = _id;
        tokenList[_vpk].TiList[_i].Data = _Ti;

    }

    function getTi(uint _i, address _tpk, address _vpk, string memory tmpvalue) public view returns (string memory){
        require(msg.sender == _tpk);
        require(tpkList[_i] == _tpk);
        string memory tmpstr;
        tmpvalue = "";
        uint i;
		for(i = 0; i < t_T; i ++)
		{
            tmpstr = tokenList[_vpk].TiList[i].id;
		    tmpvalue = tmpvalue.toSlice().concat(tmpstr.toSlice());
            tmpstr = tokenList[_vpk].TiList[i].Data;
		    tmpvalue = tmpvalue.toSlice().concat(tmpstr.toSlice());

        }
        return tmpvalue;
    } 

    function uploadIden(uint _i, address _tpk, address _vpk, string memory _id) public{
        require(msg.sender == _tpk);
        require(tpkList[_i] == _tpk);
        tokenList[_vpk].id = _id;

    }

    function getIden(address _vpk) public view returns (string memory){
        require(msg.sender == _vpk);
        return tokenList[_vpk].id;
    } 

    function uploadQi(uint _i, address _tpk, string memory _id, string memory _Qi) public {
        require(msg.sender == _tpk);
        require(tpkList[_i] == _tpk);
        QiList[_i].id = _id;
        QiList[_i].Data = _Qi;
    }

    function getQi(uint _i, address _tpk, string memory tmpvalue) public view returns (string memory){
        require(msg.sender == _tpk);
        require(tpkList[_i] == _tpk);
        string memory tmpstr;
        tmpvalue = "";
        uint i;
		for(i = 0; i < t_T; i ++)
		{
            tmpstr = QiList[i].id;
		    tmpvalue = tmpvalue.toSlice().concat(tmpstr.toSlice());
            tmpstr = QiList[i].Data;
		    tmpvalue = tmpvalue.toSlice().concat(tmpstr.toSlice());

        }
        return tmpvalue;
    } 

    function uploadRev(uint _i, address _tpk, string memory _rev) public{
        require(msg.sender == _tpk);
        require(tpkList[_i] == _tpk);
        revList.push(_rev);
    }

    function getRev(address _vpk, string memory tmpvalue) public view returns (string memory){
        require(msg.sender == _vpk);
        string memory tmpstr;
        tmpvalue = "";
        uint i;
		for(i = 0; i < revList.length; i ++)
		{
            tmpstr = revList[i];
		    tmpvalue = tmpvalue.toSlice().concat(tmpstr.toSlice());

        }
        return tmpvalue;        
    } 









}