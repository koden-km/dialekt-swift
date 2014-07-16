/// Protocol for expression visitors.
protocol ExpressionVisitorProtocol {
//    typealias VisitResultType
    typealias VisitResultTypeExpression    // maybe this typealias cant be the same name as the pattern visitor result type
    
    /// Visit a LogicalAnd node.
//    func visitLogicalAnd(node: LogicalAnd) -> VisitResultType
    func visitLogicalAnd(node: LogicalAnd) -> VisitResultTypeExpression
    
    /// Visit a LogicalOr node.
//    func visitLogicalOr(node: LogicalOr) -> VisitResultType
    func visitLogicalOr(node: LogicalOr) -> VisitResultTypeExpression
    
    /// Visit a LogicalNot node.
//    func visitLogicalNot(node: LogicalNot) -> VisitResultType
    func visitLogicalNot(node: LogicalNot) -> VisitResultTypeExpression
    
    /// Visit a Tag node.
//    func visitTag(node: Tag) -> VisitResultType
    func visitTag(node: Tag) -> VisitResultTypeExpression
    
    /// Visit a pattern node.
//    func visitPattern(node: Pattern) -> VisitResultType
    func visitPattern(node: Pattern) -> VisitResultTypeExpression
    
    /// Visit a EmptyExpression node.
//    func visitEmptyExpression(node: EmptyExpression) -> VisitResultType
    func visitEmptyExpression(node: EmptyExpression) -> VisitResultTypeExpression
}
