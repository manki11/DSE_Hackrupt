pragma solidity ^0.4.18;

contract owned {
    address owner;
    function owned() public{
        owner = msg.sender;
    }
    modifier onlyOwner(){
        require( msg.sender == owner);
        _;
    }
}

contract DSE is owned {

    struct User {
    uint stocknumbers;
    mapping(bytes16 => Stocks) stocks;
    bytes16[] company_names;
    }

    struct Stocks{
    // uint256 id;
    // bytes16 company;
    // address owner;
    uint count;
    uint price;
    }

    mapping(address => User) users;
    address[] public userAccts;

    function setUser(address _address) public{
        var user = users[_address];
        userAccts.push(_address) -1;
    }

    function getusers() view public returns(address[]){
        return userAccts;
    }

    function getUser(address _address) view public returns(uint){
        return (users[_address].stocknumbers);
    }

    function countUsers() view public returns(uint){
        return userAccts.length;
    }

    function addStock(bytes16 _company_name, uint _count, address _seller, uint _price) public returns(uint) {
        var seller= users[_seller];
        seller.stocks[_company_name].count += _count;
        seller.stocks[_company_name].price += _price;

        if(seller.company_names.length ==0){
            seller.company_names.push(_company_name);
        }
        else{
            for(uint8 i = 0; i <= seller.company_names.length; i++){
                if(_company_name == seller.company_names[i]){
                    break;
                }
                if(i+1== seller.company_names.length){
                    seller.company_names.push(_company_name);
                }
            }
        }

        seller.stocknumbers+= _count;
        return seller.company_names.length;
    }

    function getStocksOfUser(address _address) view public returns(uint){
        var user= users[_address];

        Stocks[] memory temp= new Stocks[](user.company_names.length);

        // Stocks temp= user.stocks[user.company_names[0]];
        for(uint i=0;i< user.company_names.length;i++){
            temp[i]= user.stocks[user.company_names[i]];
        }

        return (temp.length);
    }

//     function sellStock(bytes16 _company_name, uint _count, address _seller) constant public returns(bytes16, uint, address){
//         var seller= users[_seller];
//
//         require(seller.stocks[_company_name]> _count);
//
//         return (_company_name, _count, _seller);
//     }
}