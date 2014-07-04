// Protocol for expression visitors.
protocol ExpressionVisitorProtocol {
    // Generic return type does not seem to work when used below...
    //typealias ReturnType
    
    // Visit a LogicalAnd node.
    func visitLogicalAnd(node: LogicalAnd) -> ExpressionResult
    
    // Visit a LogicalOr node.
    func visitLogicalOr(node: LogicalOr) -> ExpressionResult
    
    // Visit a LogicalNot node.
    func visitLogicalNot(node: LogicalNot) -> ExpressionResult
    
    // Visit a Tag node.
    func visitTag(node: Tag) -> ExpressionResult
    
    // Visit a pattern node.
    func visitPattern(node: Pattern) -> ExpressionResult
    
    // Visit a EmptyExpression node.
    func visitEmptyExpression(node: EmptyExpression) -> ExpressionResult
}
