// An AST node that is a child of a pattern-match expression.
protocol PatternChildProtocol: NodeProtocol {
//    typealias ReturnType
    
    // Pass this node to the appropriate method on the given visitor.
//    func accept(visitor: PatternChildVisitorProtocol) -> ReturnType
    func accept(visitor: PatternChildVisitorProtocol) -> String
}
