/// Protocol for pattern child visitors.
protocol PatternChildVisitorProtocol {
//    typealias VisitResultType
    typealias VisitResultTypePattern    // maybe this typealias cant be the same name as the expression visitor result type
    
    /// Visit a PatternLiteral node.
//    func visitPatternLiteral(node: PatternLiteral) -> VisitResultType
    func visitPatternLiteral(node: PatternLiteral) -> VisitResultTypePattern
    
    /// Visit a PatternWildcard node.
//    func visitPatternWildcard(node: PatternWildcard) -> VisitResultType
    func visitPatternWildcard(node: PatternWildcard) -> VisitResultTypePattern
}
