/// Protocol for node visitors.
protocol VisitorProtocol: ExpressionVisitorProtocol, PatternChildVisitorProtocol {
    typealias VisitorResultType

    /// Visit a LogicalAnd node.
    func visitLogicalAnd(node: LogicalAnd) -> VisitorResultType

    /// Visit a LogicalOr node.
    func visitLogicalOr(node: LogicalOr) -> VisitorResultType

    /// Visit a LogicalNot node.
    func visitLogicalNot(node: LogicalNot) -> VisitorResultType

    /// Visit a Tag node.
    func visitTag(node: Tag) -> VisitorResultType

    /// Visit a pattern node.
    func visitPattern(node: Pattern) -> VisitorResultType

    /// Visit a EmptyExpression node.
    func visitEmptyExpression(node: EmptyExpression) -> VisitorResultType

    /// Visit a PatternLiteral node.
    func visitPatternLiteral(node: PatternLiteral) -> VisitorResultType

    /// Visit a PatternWildcard node.
    func visitPatternWildcard(node: PatternWildcard) -> VisitorResultType
}
