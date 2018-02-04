pragma solidity ^0.4.18;


contract owned {
    address owner;

    function owned() public {
        owner = msg.sender;
    }
    modifier onlyOwner(){
        require(msg.sender == owner);
        _;
    }
}


contract DSE is owned {

    struct User {
    uint stocknumbers;
    mapping (bytes16 => Stocks) stocks;
    bytes16[] company_names;
    }

    struct Sell_Stock {
    bytes16 company;
    address owner;
    uint count;
    uint price;
    }

    Sell_Stock[] sellingList;

    struct Stocks {
    // uint256 id;
    // bytes16 company;
    // address owner;
    uint count;
    uint price;
    }

    // Events
    event addStockEvent (
    bytes16 company_name,
    uint count,
    uint price
    );

    mapping (address => User) users;

    address[] public userAccts;

    function setUser(address _address) public returns (address) {
        var user = users[_address];
        if (userAccts.length == 0) {
            userAccts.push(_address);
        }
        else {
            for (uint i = 0; i < userAccts.length; i++) {
                if (userAccts[i] == _address) {
                    break;
                }
                if (i + 1 == userAccts.length) {
                    userAccts.push(_address);
                }
            }
        }

        return _address;
    }

    function getusers() constant public returns (address[]){
        return userAccts;
    }

    function getCurrentUserStock(address _address) constant public returns (uint){
        return (users[_address].stocknumbers);
    }

    function countUsers() constant public returns (uint){
        return userAccts.length;
    }

    function addStock(bytes16 _company_name, uint _count, address _seller, uint _price) public {
        var seller = users[_seller];
        seller.stocks[_company_name].count += _count;
        seller.stocks[_company_name].price = _price;

        if (seller.company_names.length == 0) {
            seller.company_names.push(_company_name);
        }
        else {
            for (uint8 i = 0; i <= seller.company_names.length; i++) {
                if (_company_name == seller.company_names[i]) {
                    break;
                }
                if (i + 1 == seller.company_names.length) {
                    seller.company_names.push(_company_name);
                }
            }
        }
        seller.stocknumbers += _count;
        addStockEvent(_company_name,_count,_price);
    }

    function getNoOfStockOfUser(address _address) constant public returns (uint){
        var user = users[_address];
        return user.company_names.length;
    }

    function getStock(address _address, uint i) constant public returns (bytes16){
        var user = users[_address];
        bytes16 company_name= user.company_names[i];
        return company_name;
    }

//    function getStocksOfUser(address _address) view public returns (Stocks){
//        var user = users[_address];
//
//        Stocks[] memory temp = new Stocks[](user.company_names.length);
//
//        // Stocks temp= user.stocks[user.company_names[0]];
//        for (uint i = 0; i < user.company_names.length; i++) {
//            temp[i] = user.stocks[user.company_names[i]];
//        }
//
//        return (temp[0]);
//    }

    function sellStock(bytes16 _company_name, uint _count, address _seller, uint _price) public returns (bytes16, uint, address, uint){
        var seller = users[_seller];

        require(seller.stocks[_company_name].count > 0);

        Sell_Stock memory temp;
        temp.owner = _seller;
        temp.company = _company_name;
        temp.count = _count;
        temp.price = _price;

        sellingList.push(temp);

        return (_company_name, _count, _seller, _price);
    }

    function getSellingList()  public returns (Sell_Stock[]){
        return sellingList;
    }
}