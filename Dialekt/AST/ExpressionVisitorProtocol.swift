/// Protocol for expression visitors.
public protocol ExpressionVisitorProtocol {
    typealias ExpressionVisitorResultType

    /// Visit a LogicalAnd node.
    func visit(node: LogicalAnd) -> ExpressionVisitorResultType

    /// Visit a LogicalOr node.
    func visit(node: LogicalOr) -> ExpressionVisitorResultType

    /// Visit a LogicalNot node.
    func visit(node: LogicalNot) -> ExpressionVisitorResultType

    /// Visit a Tag node.
    func visit(node: Tag) -> ExpressionVisitorResultType

    /// Visit a pattern node.
    func visit(node: Pattern) -> ExpressionVisitorResultType

    /// Visit a EmptyExpression node.
    func visit(node: EmptyExpression) -> ExpressionVisitorResultType
}
