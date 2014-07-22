///// An AST node that represents the logical OR operator.
public class LogicalOr: AbstractPolyadicExpression, ExpressionProtocol {
    /// Pass this node to the appropriate method on the given visitor.
    public func accept<T: VisitorProtocol>(visitor: T) -> T.VisitorResultType {
        return visitor.visit(self) as T.VisitorResultType
    }

    /// Pass this node to the appropriate method on the given visitor.
    public func accept<T: ExpressionVisitorProtocol>(visitor: T) -> T.ExpressionVisitorResultType {
        return visitor.visit(self)
    }
}
