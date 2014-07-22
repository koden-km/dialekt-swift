/// An AST node that represents a literal tag expression.
public class Tag: AbstractExpression, ExpressionProtocol {
    public init(_ name: String) {
        _name = name
    }

    /// Fetch the tag name.
    public func name() -> String {
        return _name
    }

    /// Pass this node to the appropriate method on the given visitor.
    public func accept<T: VisitorProtocol>(visitor: T) -> T.VisitorResultType {
        return visitor.visit(self) as T.VisitorResultType
    }

    /// Pass this node to the appropriate method on the given visitor.
    public func accept<T: ExpressionVisitorProtocol>(visitor: T) -> T.ExpressionVisitorResultType {
        return visitor.visit(self)
    }

    private let _name: String
}
