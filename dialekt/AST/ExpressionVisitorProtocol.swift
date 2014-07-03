// Protocol for expression visitors.
protocol ExpressionVisitorProtocol {
    typealias ExpressionVisitorProtocolReturnType
    
    // Visit a LogicalAnd node.
    func visitLogicalAnd(node: LogicalAnd) -> ExpressionVisitorProtocolReturnType
    
    // Visit a LogicalOr node.
    func visitLogicalOr(node: LogicalOr) -> ExpressionVisitorProtocolReturnType
    
    // Visit a LogicalNot node.
    func visitLogicalNot(node: LogicalNot) -> ExpressionVisitorProtocolReturnType
    
    // Visit a Tag node.
    func visitTag(node: Tag) -> ExpressionVisitorProtocolReturnType
    
    // Visit a pattern node.
    func visitPattern(node: Pattern) -> ExpressionVisitorProtocolReturnType
    
    // Visit a EmptyExpression node.
    func visitEmptyExpression(node: EmptyExpression) -> ExpressionVisitorProtocolReturnType
}
