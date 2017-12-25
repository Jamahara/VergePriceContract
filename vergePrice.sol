/*
   XVG Price

   This contract keeps a reference
   to the Verge Price in USD
*/


pragma solidity ^0.4.0;
import "github.com/oraclize/ethereum-api/oraclizeAPI.sol";

contract VergePrice is usingOraclize {
    
    uint public VergePriceUSD;

    event newOraclizeQuery(string description);
    event newVergePrice(string price);

    function VergePrice() {
        update(); // first check at contract creation
    }

    function __callback(bytes32 myid, string result) {
        if (msg.sender != oraclize_cbAddress()) throw;
        newVergePrice(result);
        VergePriceUSD = parseInt(result, 2); // let's save it as $ cents
    }
    
    function update() payable {
        newOraclizeQuery("Oraclize query sent, waiting for an answer..");
        oraclize_query("URL", "xml(https://api.coinmarketcap.com/v1/ticker/verge/).price_usd");
    }
    
}

