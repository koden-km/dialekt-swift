protocol VisitorProtocol: ExpressionVisitorProtocol, PatternChildVisitorProtocol {
    typealias VisitorResultType

    func visitLogicalAnd(node: LogicalAnd) -> VisitorResultType
    func visitLogicalOr(node: LogicalOr) -> VisitorResultType
    func visitLogicalNot(node: LogicalNot) -> VisitorResultType
    func visitTag(node: Tag) -> VisitorResultType
    func visitPattern(node: Pattern) -> VisitorResultType
    func visitEmptyExpression(node: EmptyExpression) -> VisitorResultType

    func visitPatternLiteral(node: PatternLiteral) -> VisitorResultType
    func visitPatternWildcard(node: PatternWildcard) -> VisitorResultType
}
