// An AST node.
protocol NodeProtocol {
    typealias ReturnType
    
    // Pass this node to the appropriate method on the given visitor.
    func accept(visitor: VisitorProtocol) -> ReturnType
}
