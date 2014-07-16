/// An AST node that represents the logical NOT operator.
class LogicalNot: AbstractExpression, ExpressionProtocol {
    let _child: ExpressionProtocol
//    let _child: Any

    init(child: ExpressionProtocol) {
//    init<T: ExpressionProtocol>(child: T) {
        _child = child
    }
    
    /// Fetch the expression being inverted by the NOT operator.
    func child() -> ExpressionProtocol {
//    func child() -> Any {
        return _child
    }
    
    /// Pass this node to the appropriate method on the given visitor.
//    func accept<T: VisitorProtocol>(visitor: T) -> Any {
//    func accept<T: VisitorProtocol>(visitor: T) -> T.VisitResultType {
//    func accept<T: VisitorProtocol>(visitor: T) -> T.VisitResultTypeExpression {
//        return visitor.visitLogicalNot(self)
//    }

    /// Pass this node to the appropriate method on the given visitor.
//    func accept<T: ExpressionVisitorProtocol>(visitor: T) -> ExpressionResult {
//    func accept<T: ExpressionVisitorProtocol>(visitor: T) -> T.VisitResultType {
    func accept<T: ExpressionVisitorProtocol>(visitor: T) -> T.VisitResultTypeExpression {
        return visitor.visitLogicalNot(self)
    }
}
