/// An AST node that represents a pattern-match expression.
class Pattern: AbstractExpression, ExpressionProtocol {
    init(_ children: [PatternChildProtocol]) {
        _children = children

        super.init()
    }

    convenience init(_ children: PatternChildProtocol...) {
        self.init(children)
    }

    /// Add a child to this node.
    func add(node: PatternChildProtocol) {
        _children.append(node)
    }

    /// Fetch an array of this node's children.
    func children() -> [PatternChildProtocol] {
        return _children
    }

    /// Pass this node to the appropriate method on the given visitor.
    func accept<T: VisitorProtocol>(visitor: T) -> T.VisitorResultType {
        return visitor.visit(self) as T.VisitorResultType
    }

    /// Pass this node to the appropriate method on the given visitor.
    func accept<T: ExpressionVisitorProtocol>(visitor: T) -> T.ExpressionVisitorResultType {
        return visitor.visit(self)
    }

    var _children: [PatternChildProtocol]
}
