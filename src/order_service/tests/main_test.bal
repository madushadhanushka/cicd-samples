import ballerina/io;
import ballerina/test;
import ballerina/http;

http:Client clientEP = new("http://localhost:9090/OrderService");

# Before test function
function beforeFunc() {
    io:println("I'm the before function!");
}

# Test function
@test:Config {
    before: "beforeFunc",
    after: "afterFunc"
}
function testFunction() {
    io:println("I'm in test function!");
    test:assertTrue(true, msg = "Failed!");
}

# After test function
function afterFunc() {
    io:println("I'm the after function!");
}
