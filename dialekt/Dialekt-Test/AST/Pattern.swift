/// An AST node that represents a pattern-match expression.
class Pattern: AbstractExpression, ExpressionProtocol {

    init(_ children: [PatternChildProtocol]) {
        _children = children;

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

    func accept<T: VisitorProtocol>(visitor: T) -> T.VisitorResultType {
        return visitor.visitPattern(self) as T.VisitorResultType
    }

    func accept<T: ExpressionVisitorProtocol>(visitor: T) -> T.ExpressionVisitorResultType {
        return visitor.visitPattern(self)
    }
    
    var _children: [PatternChildProtocol]
}
