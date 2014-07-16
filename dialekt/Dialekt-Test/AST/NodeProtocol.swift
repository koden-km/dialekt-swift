/// An AST node.
protocol NodeProtocol {
    /// Pass this node to the appropriate method on the given visitor.
    func accept<T: VisitorProtocol>(visitor: T) -> T.VisitorResultType
}
