import ballerina/http;
import ballerina/docker;

@docker:Expose {}
listener http:Listener orderEP = new(9090);
service OrderService on orderEP {
    resource function addOrder(http:Caller caller,
        http:Request req) returns error? {
        check caller->respond("Order added");
    }
}