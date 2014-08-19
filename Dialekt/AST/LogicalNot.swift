/// An AST node that represents the logical NOT operator.
public class LogicalNot: AbstractExpression, ExpressionProtocol {
    public init(_ child: ExpressionProtocol) {
        _child = child
    }

    /// Fetch the expression being inverted by the NOT operator.
    public func child() -> ExpressionProtocol {
        return _child
    }

    /// Pass this node to the appropriate method on the given visitor.
    public override func accept<T: VisitorProtocol>(visitor: T) -> T.VisitorResultType {
        return visitor.visit(self) as T.VisitorResultType
    }

    /// Pass this node to the appropriate method on the given visitor.
    public override func accept<T: ExpressionVisitorProtocol>(visitor: T) -> T.ExpressionVisitorResultType {
        return visitor.visit(self)
    }

    private let _child: ExpressionProtocol
}
