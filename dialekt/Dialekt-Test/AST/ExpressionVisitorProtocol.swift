/// Protocol for expression visitors.
protocol ExpressionVisitorProtocol {
    typealias ExpressionVisitorResultType;

    /// Visit a LogicalAnd node.
    func visitLogicalAnd(node: LogicalAnd) -> ExpressionVisitorResultType

    /// Visit a LogicalOr node.
    func visitLogicalOr(node: LogicalOr) -> ExpressionVisitorResultType

    /// Visit a LogicalNot node.
    func visitLogicalNot(node: LogicalNot) -> ExpressionVisitorResultType

    /// Visit a Tag node.
    func visitTag(node: Tag) -> ExpressionVisitorResultType

    /// Visit a pattern node.
    func visitPattern(node: Pattern) -> ExpressionVisitorResultType

    /// Visit a EmptyExpression node.
    func visitEmptyExpression(node: EmptyExpression) -> ExpressionVisitorResultType
}
