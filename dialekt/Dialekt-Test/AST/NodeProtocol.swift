/// An AST node.
protocol NodeProtocol {
//    typealias VisitationResultType
    
    /// Pass this node to the appropriate method on the given visitor.
//    func accept(visitor: VisitorProtocol) -> VisitationResultType
//    func accept<T: VisitorProtocol>(visitor: T) -> VisitationResultType
    func accept<T: VisitorProtocol>(visitor: T) -> T.VisitResultType
}
