pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

contract TokenContract {

    struct Token {
        string car;
        uint length;
        uint weight;
        uint power;
    }

    Token[] tokensArr;

    mapping (uint => uint) TokenToOwner;

    function createToken(string car, uint length, uint weight, uint power) public { //checkNamesOfToken
        tvm.accept();
        tokensArr.push(Token(car, length, weight, power));
        uint keyAsLastNum = tokensArr.length - 1;
        TokenToOwner[keyAsLastNum] = msg.pubkey();
    }

    // modifier checkNamesOfToken(string car) {
    //     // require(Token(car) != tokensArr(Token[car]));
    //     _;
    // }

    modifier checkOwner {
        require(msg.pubkey() == tvm.pubkey(), 100);
        _;
    }

    function exposTokenOnSail(uint price) public pure checkOwner returns(uint){
        tvm.accept();
        return price;
    }

    constructor() public {
        require(tvm.pubkey() != 0, 101);
        require(msg.pubkey() == tvm.pubkey(), 102);
        tvm.accept();
    }
}
