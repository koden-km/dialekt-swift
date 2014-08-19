import Dialekt

class MockExpressionVisitorProtocol: ExpressionVisitorProtocol {
    func visit(node: LogicalAnd) -> String {
        return "<ExpressionVisitorProtocol visit result: LogicalAnd>"
    }

    func visit(node: LogicalOr) -> String {
        return "<ExpressionVisitorProtocol visit result: LogicalOr>"
    }

    func visit(node: LogicalNot) -> String {
        return "<ExpressionVisitorProtocol visit result: LogicalNot>"
    }

    func visit(node: Tag) -> String {
        return "<ExpressionVisitorProtocol visit result: Tag>"
    }

    func visit(node: Dialekt.Pattern) -> String {
        return "<ExpressionVisitorProtocol visit result: Pattern>"
    }

    func visit(node: EmptyExpression) -> String {
        return "<ExpressionVisitorProtocol visit result: EmptyExpression>"
    }
}
