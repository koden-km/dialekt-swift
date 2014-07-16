/// An AST node that is a child of a pattern-match expression.
protocol PatternChildProtocol: NodeProtocol {
//    typealias VisitationResultType
    
    /// Pass this node to the appropriate method on the given visitor.
//    func accept<T: PatternChildVisitorProtocol>(visitor: T) -> VisitationResultType
//    func accept<T: PatternChildVisitorProtocol>(visitor: T) -> T.VisitResultType
    func accept<T: PatternChildVisitorProtocol>(visitor: T) -> T.VisitResultTypePattern
}
