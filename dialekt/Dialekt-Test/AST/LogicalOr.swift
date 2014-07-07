// An AST node that represents the logical OR operator.
class LogicalOr: AbstractPolyadicExpression, ExpressionProtocol {
    init(args: ExpressionProtocol...) {
        super.init(args: args)
    }
    
    // Pass this node to the appropriate method on the given visitor.
    func accept(visitor: VisitorProtocol) -> Any {
        return visitor.visitLogicalOr(self)
    }

    // Pass this node to the appropriate method on the given visitor.
    func accept(visitor: ExpressionVisitorProtocol) -> ExpressionResult {
        return visitor.visitLogicalOr(self)
    }
}
