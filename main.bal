import ballerina/http;
import ballerinax/java.jdbc;
 
listener http:Listener orderEP = new(9090);
service /OrderService on new http:Listener(9090) {
    resource function get addOrder() returns string {
        return "Order added";
    }

}
function getAvailableProductQuantity(jdbc:Client jdbcClient, string inventoryItemId) returns @untainted int|error {
    stream<record{}, error> resultStream = jdbcClient->query(`SELECT Quantity FROM InventoryItems WHERE 
    InventoryItemId = ${inventoryItemId}`);
    record {|record {} value;|}? result = check resultStream.next();
    if (result is record {|record {} value;|}) {
        return <int>result.value["Quantity"];
    }
    return error("Inventory table is empty");
}
function checkValidOrder(jdbc:Client jdbcClient, OrderItemTable orderItems) returns boolean|error{
    foreach OrderItem item in orderItems {
        int orderQuantity = item.quantity;
        int inventoryQuantity = check getAvailableProductQuantity(jdbcClient, item.inventoryItemId);
        if orderQuantity > inventoryQuantity {
            return false;
        }
    }
    return true;
}