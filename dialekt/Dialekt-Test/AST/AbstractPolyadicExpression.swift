/// A base class providing common functionality for polyadic operators.
class AbstractPolyadicExpression: AbstractExpression {
    init(_ children: [ExpressionProtocol]) {
        _children = children

        super.init()
    }
    
    convenience init(_ children: ExpressionProtocol...) {
        self.init(children)
    }
    
    /// Add a child expression to this operator.
    func add(expression: ExpressionProtocol) {
        _children.append(expression)
    }
    
    /// Fetch an array of this operator's children.
    func children() -> [ExpressionProtocol] {
        return _children
    }
    
    var _children: [ExpressionProtocol]
}
