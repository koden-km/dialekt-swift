import Foundation

//let renderer = ExpressionRenderer()
//let expression = LogicalAnd(
//    Tag("bob"),
//    Tag("ann")
//)

let parser = ListParser()
let expression = parser.parseTokens([
    Token(TokenType.Text, "foo", 0, 0, 0, 0),
    Token(TokenType.Text, "bar", 0, 0, 0, 0)
])
let renderer = ExpressionRenderer()

println(renderer.render(expression))
