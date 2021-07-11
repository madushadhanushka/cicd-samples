import ballerina/test;
@test:Config {}
function testSimpleTest() {
    test:assertEquals(true, true, "Assert is false");
}