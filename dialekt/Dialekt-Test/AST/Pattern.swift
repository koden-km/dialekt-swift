/// An AST node that represents a pattern-match expression.
public class Pattern: AbstractExpression, ExpressionProtocol {
    public init(_ children: [PatternChildProtocol]) {
        _children = children

        super.init()
    }

    public convenience init(_ children: PatternChildProtocol...) {
        self.init(children)
    }

    /// Add a child to this node.
    public func add(node: PatternChildProtocol) {
        _children.append(node)
    }

    /// Fetch an array of this node's children.
    public func children() -> [PatternChildProtocol] {
        return _children
    }

    /// Pass this node to the appropriate method on the given visitor.
    public func accept<T: VisitorProtocol>(visitor: T) -> T.VisitorResultType {
        return visitor.visit(self) as T.VisitorResultType
    }

    /// Pass this node to the appropriate method on the given visitor.
    public func accept<T: ExpressionVisitorProtocol>(visitor: T) -> T.ExpressionVisitorResultType {
        return visitor.visit(self)
    }

    private var _children: [PatternChildProtocol]
}
