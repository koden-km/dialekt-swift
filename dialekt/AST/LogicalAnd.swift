// An AST node that represents the logical AND operator.
class LogicalAnd: AbstractPolyadicExpression {
    init(args: ExpressionProtocol...) {
        super.init(args: args)
    }

    // Pass this node to the appropriate method on the given visitor.
    override func accept(visitor: VisitorProtocol) -> Any {
        return visitor.visitLogicalAnd(self)
    }
}
