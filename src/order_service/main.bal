import ballerina/http;
service OrderService on new http:Listener(9090) {
    resource function addOrder(http:Caller caller,
        http:Request req) returns error? {
        check caller->respond("Order added");
    }
}