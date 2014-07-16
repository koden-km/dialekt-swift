/// An AST node.
protocol NodeProtocol {
//    typealias VisitationResultType
    
    /// Pass this node to the appropriate method on the given visitor.
//    func accept(visitor: VisitorProtocol) -> VisitationResultType
//    func accept<T: VisitorProtocol>(visitor: T) -> VisitationResultType
//    func accept<T: VisitorProtocol>(visitor: T) -> T.VisitResultType
//    func accept<T: VisitorProtocol>(visitor: T) -> T.VisitResultTypeFoo
//    func accept<T: VisitorProtocol>(visitor: T) -> T.VisitResultTypeExpression
//    func accept<T: VisitorProtocol>(visitor: T) -> T.VisitResultTypePattern
//    func accept<T: VisitorProtocol>(visitor: T) -> Any



//    typealias VisitResultTypeNode
//    func accept<T: VisitorProtocol>(visitor: T) -> VisitResultTypeNode

    // TESTING: maybe this isnt required due to Swifts style of generic protocols? :S
//    func accept<T: VisitorProtocol>(visitor: T) -> Any
}
