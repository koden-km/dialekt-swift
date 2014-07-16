/// An AST node that is a child of a pattern-match expression.
protocol PatternChildProtocol: NodeProtocol {
    /// Pass this node to the appropriate method on the given visitor.
    func accept<T: PatternChildVisitorProtocol>(visitor: T) -> T.PatternChildVisitorResultType
}
