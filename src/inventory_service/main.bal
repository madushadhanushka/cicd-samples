import ballerina/http;
service InventoryService on new http:Listener(9091) {
    resource function addProduct(http:Caller caller,
        http:Request req) returns error? {
        check caller->respond("Product added");
    }
}