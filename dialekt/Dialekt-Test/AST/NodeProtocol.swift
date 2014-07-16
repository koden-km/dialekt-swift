/// An AST node.
protocol NodeProtocol {
    func accept<T: VisitorProtocol>(visitor: T) -> T.VisitorResultType
}
