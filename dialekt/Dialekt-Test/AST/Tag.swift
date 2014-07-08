/// An AST node that represents a literal tag expression.
class Tag: AbstractExpression, ExpressionProtocol {
    let _name: String

    init(name: String) {
        _name = name
    }
    
    /// Fetch the tag name.
    func name() -> String {
        return _name
    }
    
    /// Pass this node to the appropriate method on the given visitor.
    func accept(visitor: VisitorProtocol) -> Any {
        return visitor.visitTag(self)
    }

    /// Pass this node to the appropriate method on the given visitor.
    func accept(visitor: ExpressionVisitorProtocol) -> ExpressionResult {
        return visitor.visitTag(self)
    }
}
