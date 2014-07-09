/// Protocol for expression visitors.
protocol ExpressionVisitorProtocol {
    typealias VisitResultType
    
    /// Visit a LogicalAnd node.
    func visitLogicalAnd(node: LogicalAnd) -> VisitResultType
    
    /// Visit a LogicalOr node.
    func visitLogicalOr(node: LogicalOr) -> VisitResultType
    
    /// Visit a LogicalNot node.
    func visitLogicalNot(node: LogicalNot) -> VisitResultType
    
    /// Visit a Tag node.
    func visitTag(node: Tag) -> VisitResultType
    
    /// Visit a pattern node.
    func visitPattern(node: Pattern) -> VisitResultType
    
    /// Visit a EmptyExpression node.
    func visitEmptyExpression(node: EmptyExpression) -> VisitResultType
}
