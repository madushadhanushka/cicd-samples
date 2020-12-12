import ballerina/http;
import ballerina/docker;
 
@docker:Config {
   push: true,
   registry: "index.docker.io/$env{docker_username}",
   name: "order_invoice",
   tag: "v1.0.0",
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