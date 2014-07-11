/// An AST node that represents the logical OR operator.
class LogicalOr: AbstractPolyadicExpression, ExpressionProtocol {
    init(args: ExpressionProtocol...) {
//    init<T: ExpressionProtocol>(args: T...) {
        super.init(args: args)
    }
    
    /// Pass this node to the appropriate method on the given visitor.
//    func accept<T: VisitorProtocol>(visitor: T) -> Any {
    func accept<T: VisitorProtocol>(visitor: T) -> T.VisitResultType {
        return visitor.visitLogicalOr(self)
    }

    /// Pass this node to the appropriate method on the given visitor.
//    func accept<T: ExpressionVisitorProtocol>(visitor: T) -> ExpressionResult {
    func accept<T: ExpressionVisitorProtocol>(visitor: T) -> T.VisitResultType {
        return visitor.visitLogicalOr(self)
    }
}
