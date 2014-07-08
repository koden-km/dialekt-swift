/// An AST node that is a child of a pattern-match expression.
protocol PatternChildProtocol: NodeProtocol {
    // Generic return type does not seem to work when used below...
    //typealias ReturnType
    
    /// Pass this node to the appropriate method on the given visitor.
    func accept(visitor: PatternChildVisitorProtocol) -> String
}
