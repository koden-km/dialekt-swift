// Protocol for pattern child visitors.
protocol PatternChildVisitorProtocol {
    // Generic return type does not seem to work when used below...
    typealias VisitResultType
    
    // Visit a PatternLiteral node.
    func visitPatternLiteral(node: PatternLiteral) -> VisitResultType
    
    // Visit a PatternWildcard node.
    func visitPatternWildcard(node: PatternWildcard) -> VisitResultType
}
