/// A base class providing common functionality for polyadic operators.
class AbstractPolyadicExpression: AbstractExpression {

    init(_ children: [ExpressionProtocol]) {
        _children = children;

        super.init()
    }
    
    convenience init(_ children: ExpressionProtocol...) {
        self.init(children)
    }
    
    func add(expression: ExpressionProtocol) {
        _children.append(expression)
    }
    
    func children() -> [ExpressionProtocol] {
        return _children
    }
    
    var _children: [ExpressionProtocol];
}
