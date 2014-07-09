/// An AST node that represents a pattern-match expression.
class Pattern: AbstractExpression, ExpressionProtocol {
    var _children = [PatternChildProtocol]()
//    var _children = [Any]()
    
    init<T: PatternChildProtocol>(args: [T]) {
        super.init()

        for expression in args {
            self.add(expression)
        }
    }
    
    convenience init<T: PatternChildProtocol>(args: T...) {
        self.init(args: args)
    }
    
    /// Add a child to this node.
    func add(expression: PatternChildProtocol) {
//    func add<T: PatternChildProtocol>(expression: T) {
        _children.append(expression)
    }
    
    /// Fetch an array of this node's children.
    func children() -> [PatternChildProtocol] {
//    func children() -> [Any] {
        return _children
    }
    
    /// Pass this node to the appropriate method on the given visitor.
//    func accept<T: VisitorProtocol>(visitor: T) -> Any {
    func accept<T: VisitorProtocol>(visitor: T) -> T.VisitResultType {
        return visitor.visitPattern(self)
    }

    /// Pass this node to the appropriate method on the given visitor.
//    func accept<T: ExpressionVisitorProtocol>(visitor: T) -> ExpressionResult {
    func accept<T: ExpressionVisitorProtocol>(visitor: T) -> T.VisitResultType {
        return visitor.visitPattern(self)
    }
}
