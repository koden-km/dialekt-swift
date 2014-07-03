// Protocol for pattern child visitors.
protocol PatternChildVisitorProtocol {
    typealias PatternChildVisitorProtocolReturnType
    
    // Visit a PatternLiteral node.
    func visitPatternLiteral(node: PatternLiteral) -> PatternChildVisitorProtocolReturnType
    
    // Visit a PatternWildcard node.
    func visitPatternWildcard(node: PatternWildcard) -> PatternChildVisitorProtocolReturnType
}
