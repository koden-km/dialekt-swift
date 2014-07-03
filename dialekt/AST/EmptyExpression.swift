// An AST node that represents an empty expression.
class EmptyExpression: AbstractExpression {
    // Pass this node to the appropriate method on the given visitor.
//    override func accept(visitor: VisitorProtocol) -> Any {
//        return visitor.visitEmptyExpression(self)
//    }

    // Pass this node to the appropriate method on the given visitor.
//    typealias ExpressionVisitorProtocolReturnType = ExpressionResult
    override func accept(visitor: ExpressionVisitorProtocol) -> ExpressionResult {
        return visitor.visitEmptyExpression(self)
    }
}
