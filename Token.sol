pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

contract TokenContract {

    struct Token {
        string name;
        uint length;
        uint weight;
        uint power;
    }

    struct TokensOnSail {
        string name;
        uint price;
        bool sale;
    }

    Token[] tokensArr;
    TokensOnSail[] saleArr;

    mapping (uint => uint) TokenToOwner;
    mapping (uint => uint) TokenToPrice;

    function createToken(string name, uint length, uint weight, uint power, uint price) public {
        tvm.accept();
        for(uint i=0; i < tokensArr.length; i++){
            if (tokensArr[i].name == name) {
                require;
            }
        }
        tokensArr.push(Token(name, length, weight, power));
        uint keyAsLastNum = tokensArr.length - 1;
        TokenToOwner[keyAsLastNum] = msg.pubkey();
        TokenToOwner[keyAsLastNum] = price;
    }

    modifier checkOwner(uint tokenId) {
        require(msg.pubkey() == TokenToOwner[tokenId], 101);
        _;
    }

    function givePriceToken(uint tokenId, uint price) public checkOwner(tokenId) {
        saleArr[tokenId].sale = true;
        saleArr[tokenId].price = price;
    }

    function getTokenOwner(uint tokenId) public view returns(uint) {
        return TokenToOwner[tokenId];
    }

    function exposTokenOnSail(uint tokenId) public view returns(string tokenName, uint tokenPrice, bool tokenSale) {
        tvm.accept();
        tokenName = saleArr[tokenId].name;
        tokenPrice = saleArr[tokenId].price;
        tokenSale = saleArr[tokenId].sale;
    }

    constructor() public {
        require(tvm.pubkey() != 0, 101);
        require(msg.pubkey() == tvm.pubkey(), 102);
        tvm.accept();
    }
}
