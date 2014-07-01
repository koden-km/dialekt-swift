// An AST node that represents a pattern-match expression.
class Pattern: AbstractExpression, ExpressionProtocol {
    var _children = PatternChildProtocol[]()
    
    init(args: PatternChildProtocol[]) {
        for expression in args {
            self.add(expression)
        }
    }
    
    convenience init(args: PatternChildProtocol...) {
        self.init(args: args)
    }
    
    // Add a child to this node.
    func add(expression: PatternChildProtocol) {
        _children.append(expression)
    }
    
    // Fetch an array of this node's children.
    func children() -> PatternChildProtocol[] {
        return _children
    }
    
    // Pass this node to the appropriate method on the given visitor.
    override func accept(visitor: VisitorProtocol) -> Any {
        return visitor.visitPattern(self)
    }
}
