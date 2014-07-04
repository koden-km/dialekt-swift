// Protocol for pattern child visitors.
protocol PatternChildVisitorProtocol {
    // Generic return type does not seem to work when used below...
    //typealias ReturnType
    
    // Visit a PatternLiteral node.
    func visitPatternLiteral(node: PatternLiteral) -> String
    
    // Visit a PatternWildcard node.
    func visitPatternWildcard(node: PatternWildcard) -> String
}
