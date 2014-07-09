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
//    func accept<T: VisitorProtocol>(visitor: T) -> Any {
    func accept<T: VisitorProtocol>(visitor: T) -> T.VisitResultType {
        return visitor.visitTag(self)
    }

    /// Pass this node to the appropriate method on the given visitor.
//    func accept<T: ExpressionVisitorProtocol>(visitor: T) -> ExpressionResult {
    func accept<T: ExpressionVisitorProtocol>(visitor: T) -> T.VisitResultType {
        return visitor.visitTag(self)
    }
}
