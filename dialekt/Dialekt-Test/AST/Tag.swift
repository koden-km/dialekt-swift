/// An AST node that represents a literal tag expression.
class Tag: AbstractExpression, ExpressionProtocol {

    init(_ name: String) {
        _name = name
    }
    
    /// Fetch the tag name.
    func name() -> String {
        return _name
    }

    func accept<T: VisitorProtocol>(visitor: T) -> T.VisitorResultType {
        return visitor.visitTag(self) as T.VisitorResultType
    }

    func accept<T: ExpressionVisitorProtocol>(visitor: T) -> T.ExpressionVisitorResultType {
        return visitor.visitTag(self)
    }

    let _name: String
}
