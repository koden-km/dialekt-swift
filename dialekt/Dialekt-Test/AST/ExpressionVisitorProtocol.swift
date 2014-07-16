protocol ExpressionVisitorProtocol {
    typealias ExpressionVisitorResultType;

    func visitLogicalAnd(node: LogicalAnd) -> ExpressionVisitorResultType
    func visitLogicalOr(node: LogicalOr) -> ExpressionVisitorResultType
    func visitLogicalNot(node: LogicalNot) -> ExpressionVisitorResultType
    func visitTag(node: Tag) -> ExpressionVisitorResultType
    func visitPattern(node: Pattern) -> ExpressionVisitorResultType
    func visitEmptyExpression(node: EmptyExpression) -> ExpressionVisitorResultType
}
