import ballerina/http;
import ballerina/docker;
import ballerina/jdbc;
import ballerina/c2c as _;
 
@docker:Config {
   push: true,
   registry: "index.docker.io/$env{docker_username}",
   username: "$env{docker_username}",
   password: "$env{docker_password}"
}
listener http:Listener orderEP = new(9090);
service OrderService on orderEP {
    resource function addOrder(http:Caller caller,
        http:Request req) returns error? {
        check caller->respond("Order added");
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