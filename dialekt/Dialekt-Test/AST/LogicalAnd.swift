/// An AST node that represents the logical AND operator.
class LogicalAnd: AbstractPolyadicExpression, ExpressionProtocol {
    init(args: ExpressionProtocol...) {
//    init<T: ExpressionProtocol>(args: T...) {
        super.init(args: args)
    }

    /// Pass this node to the appropriate method on the given visitor.
//    func accept<T: VisitorProtocol>(visitor: T) -> Any {
//    func accept<T: VisitorProtocol>(visitor: T) -> T.VisitResultType {
//    func accept<T: VisitorProtocol>(visitor: T) -> T.VisitResultTypeExpression {
//        return visitor.visitLogicalAnd(self)
//    }

    /// Pass this node to the appropriate method on the given visitor.
//    func accept<T: ExpressionVisitorProtocol>(visitor: T) -> ExpressionResult {
//    func accept<T: ExpressionVisitorProtocol>(visitor: T) -> T.VisitResultType {
    func accept<T: ExpressionVisitorProtocol>(visitor: T) -> T.VisitResultTypeExpression {
        return visitor.visitLogicalAnd(self)
    }
}
