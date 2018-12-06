pragma solidity ^0.4.13;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/SupplyChain.sol";

contract TestSupplyChain {
  uint public initialBalance = 1000 wei;

    // Test for failing conditions in this contracts
    // test that every modifier is working
    function () public payable {}

    // buyItem
    function testAddItemBasic() external {
        SupplyChain myContract = SupplyChain(DeployedAddresses.SupplyChain());

        // Add an item
        myContract.addItem("widget", 1 wei);
        string memory name;
        uint sku;
        uint price;
        uint state;
        address seller;
        address buyer;
        (name, sku, price, state, seller, buyer) = myContract.fetchItem(0);

        Assert.equal(name, "widget", "Name should be widget");
        Assert.equal(sku, 0, "SKU should be 0");
        Assert.equal(price, 1 wei, "price should be 1 wei");
        Assert.equal(state, 0, "state should be 0");
        Assert.equal(seller, this, "We should be the seller");
        Assert.equal(buyer, 0, "Buyer should be empty");
    }

    function testBuyItemBasic() external payable {
        SupplyChain myContract = SupplyChain(DeployedAddresses.SupplyChain());

        // Add an item
        myContract.addItem("widget", 1 wei);
        
        // Now buy the item
        myContract.buyItem.value(1 wei)(0);

        string memory name;
        uint sku;
        uint price;
        uint state;
        address seller;
        address buyer;
        (name, sku, price, state, seller, buyer) = myContract.fetchItem(0);

        Assert.equal(name, "widget", "Name should be widget");
        Assert.equal(sku, 0, "SKU should be 0");
        Assert.equal(price, 1 wei, "price should be 1 wei");
        Assert.equal(state, 1, "state should be 1");
        Assert.equal(seller, this, "We should be the seller");
        Assert.equal(buyer, this, "We should be the buyer");
    }

     
    // test for failure if user does not send enough funds
    // test for purchasing an item that is not for Sale


    // shipItem

    // test for calls that are made by not the seller
    // test for trying to ship an item that is not marked Sold

    // receiveItem

    // test calling the function from an address that is not the buyer
    // test calling the function on an item not marked Shipped

     


}
