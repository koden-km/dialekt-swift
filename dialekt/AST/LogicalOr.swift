// An AST node that represents the logical OR operator.
class LogicalOr: AbstractPolyadicExpression {
    init(args: ExpressionProtocol...) {
        super.init(args: args)
    }
    
    // Pass this node to the appropriate method on the given visitor.
    override func accept(visitor: VisitorProtocol) -> Any {
        return visitor.visitLogicalOr(self)
    }
}
