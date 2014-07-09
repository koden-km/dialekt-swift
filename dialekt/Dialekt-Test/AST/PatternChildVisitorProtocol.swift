/// Protocol for pattern child visitors.
protocol PatternChildVisitorProtocol {
    typealias VisitResultType
    
    /// Visit a PatternLiteral node.
    func visitPatternLiteral(node: PatternLiteral) -> VisitResultType
    
    /// Visit a PatternWildcard node.
    func visitPatternWildcard(node: PatternWildcard) -> VisitResultType
}
