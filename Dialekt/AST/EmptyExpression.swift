/// An AST node that represents an empty expression.
public class EmptyExpression: AbstractExpression, ExpressionProtocol {
    /// Pass this node to the appropriate method on the given visitor.
    public override func accept<T: VisitorProtocol>(visitor: T) -> T.VisitorResultType {
        return visitor.visit(self) as T.VisitorResultType
    }

    /// Pass this node to the appropriate method on the given visitor.
    public override func accept<T: ExpressionVisitorProtocol>(visitor: T) -> T.ExpressionVisitorResultType {
        return visitor.visit(self)
    }
}
