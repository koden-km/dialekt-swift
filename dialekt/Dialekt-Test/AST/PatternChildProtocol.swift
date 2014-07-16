/// An AST node that is a child of a pattern-match expression.
protocol PatternChildProtocol: NodeProtocol {

    func accept<T: PatternChildVisitorProtocol>(visitor: T) -> T.PatternChildVisitorResultType

}
