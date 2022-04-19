pragma solidity >=0.5.0 <0.6.0;

contract MyContract {

    uint stateVar = 0;

    struct Person {
        uint age;
        string name;
    }

    // dynamic array of type Person
    Person[] public users;

    // fixed size array of type unit
    uint[100] private fixedSizeArray;

    // singed integer
    int neg = - 999;

    // strings

    string str = "This is a string";

    // event declaration
    event newPersonAdded(uint Id, string name);




    // mapping declaration

    mapping(address => uint) public accountBalance;

    function passByVal(string memory _name) public {


        Person user = Person(25, "alex");

    }

    function passByRef(string storage _name) private {

    }

    function returnValFunc(string storage _name) public returns (string memory) {


        return str;
    }

    function viewFunc(string storage _name) public returns (string memory) {


        return str;
    }

    function pureFunc() private pure returns (uint) {


        keccak256(abi.encodePacked("ABCD00232"));


        uint rand = uint(keccak256(abi.encodePacked("ABCD00232")));

        return 10 % 60;
    }

    function onUserAdded(string memory _name) private {


        Person user = Person(_ID, _name);

        uint id = users.push(user);

        emit newPersonAdded(id, _name);

    }

    function setMappingValue(uint _bal) private {

        accountBalance[msg.sender] = _bal;
    }

    function getMappingValue() public view returns (uint){

        return accountBalance[msg.sender];
    }

}


// inheritance in solidity

contract Person {

    string name;
    uint age;

    constructor(string memory _name, uint _age) public {

        name = _name;
        age = _age;

    }

}

contract employee is Person {

    uint id;

    constructor(uint _id, string memory _name, uint age) Person(_name, _age) public {

        id = _id;
    }
}


// storage vs memory

contract CarFactory {

    struct Car {
        string name;
        string make;
        string model;
        string state;
    }

    Car[] cars;

    function useCar(uint _index) public {
        // solidity compiler will be telling you that you should explicitly declare `storage` or `memory` here.
        //Car myCar = cars[_index];


        // So instead, you should declare with the `storage` keyword, like:
        Car storage myCar = cars[_index];
        // ...in which case `myCar` is a pointer to `cars[_index]`
        // in storage, and...
        myCar.state = "running";
        // ...this will permanently change `cars[_index]` on the blockchain.

        // If you just want a copy, you can use `memory`:
        Car memory myCarCopy = cars[_index + 1];
        // ...in which case `myCarCopy` will simply be a copy of the
        // data in memory, and...
        myCarCopy.state = "stopped!";
        // ...will just modify the temporary variable and have no effect
        // on `cars[_index + 1]`. But you can do this:
        cars[_index + 1] = myCarCopy;
        // ...if you want to copy the changes back into blockchain storage.
    }
}





// Interface definition
contract NumberInterface {
    function getNum(address _myAddress) public view returns (uint);
}

// Accessing the external contract function using the Interface NumberInterface
contract MyContract {

    address NumberInterfaceAddress = 0xab38;
    // ^ The address of the external contract on Ethereum
    NumberInterface numberContract = NumberInterface(NumberInterfaceAddress);
    // Now `numberContract` is pointing to the other contract

    function someFunction() public {
        // Now we can call `getNum` from that contract:
        uint num = numberContract.getNum(msg.sender);

    }
}




/**
* @title Ownable
* @dev The Ownable contract has an owner address, and provides basic authorization control
* functions, this simplifies the implementation of "user permissions".
*/
contract Ownable {
address private _owner;

event OwnershipTransferred(
address indexed previousOwner,
address indexed newOwner
);

/**
 * @dev The Ownable constructor sets the original `owner` of the contract to the sender
   * account.
   */
constructor() internal {
_owner = msg.sender;
emit OwnershipTransferred(address(0), _owner);
}

/**
 * @return the address of the owner.
   */
function owner() public view returns(address) {
return _owner;
}

/**
 * @dev Throws if called by any account other than the owner.
   */
modifier onlyOwner() {
require(isOwner());
_;
}

/**
 * @return true if `msg.sender` is the owner of the contract.
   */
function isOwner() public view returns(bool) {
return msg.sender == _owner;
}

/**
 * @dev Allows the current owner to relinquish control of the contract.
   * @notice Renouncing to ownership will leave the contract without an owner.
   * It will not be possible to call the functions with the `onlyOwner`
   * modifier anymore.
   */
function renounceOwnership() public onlyOwner {
emit OwnershipTransferred(_owner, address(0));
_owner = address(0);
}

/**
 * @dev Allows the current owner to transfer control of the contract to a newOwner.
   * @param newOwner The address to transfer ownership to.
   */
function transferOwnership(address newOwner) public onlyOwner {
_transferOwnership(newOwner);
}

/**
 * @dev Transfers control of the contract to a newOwner.
   * @param newOwner The address to transfer ownership to.
   */
function _transferOwnership(address newOwner) internal {
require(newOwner != address(0));
emit OwnershipTransferred(_owner, newOwner);
_owner = newOwner;
}
}
