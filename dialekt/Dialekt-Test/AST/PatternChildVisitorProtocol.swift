/// Protocol for pattern child visitors.
protocol PatternChildVisitorProtocol {
    typealias PatternChildVisitorResultType

    /// Visit a PatternLiteral node.
    func visitPatternLiteral(node: PatternLiteral) -> PatternChildVisitorResultType

    /// Visit a PatternWildcard node.
    func visitPatternWildcard(node: PatternWildcard) -> PatternChildVisitorResultType
}
