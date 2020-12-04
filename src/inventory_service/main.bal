import ballerina/http;
import ballerina/docker;

@docker:Expose {}
listener http:Listener inventoryEP = new(9091);
@docker:Config {
    name: "inventory",
    tag: "v1.0"
}
service InventoryService on inventoryEP {
    resource function addProduct(http:Caller caller,
        http:Request req) returns error? {
        check caller->respond("Product added");
    }
}