import Foundation

let renderer = ExpressionRenderer()
let expression = LogicalAnd(
    Tag("bob"),
    Tag("ann")
)

println(expression.accept(renderer))
