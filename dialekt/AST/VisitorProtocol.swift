// Protocol for node visitors.
protocol VisitorProtocol {
    typealias ReturnType
    
    // Visit a LogicalAnd node.
    func visitLogicalAnd(node: LogicalAnd) -> ReturnType
    
    // Visit a LogicalOr node.
    func visitLogicalOr(node: LogicalOr) -> ReturnType
    
    // Visit a LogicalNot node.
    func visitLogicalNot(node: LogicalNot) -> ReturnType
    
    // Visit a Tag node.
    func visitTag(node: Tag) -> ReturnType
    
    // Visit a pattern node.
    func visitPattern(node: Pattern) -> ReturnType
    
    // Visit a PatternLiteral node.
    func visitPatternLiteral(node: PatternLiteral) -> String
    
    // Visit a PatternWildcard node.
    func visitPatternWildcard(node: PatternWildcard) -> String
    
    // Visit a EmptyExpression node.
    func visitEmptyExpression(node: EmptyExpression) -> ReturnType
}
