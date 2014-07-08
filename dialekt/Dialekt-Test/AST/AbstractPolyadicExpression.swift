/// A base class providing common functionality for polyadic operators.
class AbstractPolyadicExpression: AbstractExpression {
    var _children = ExpressionProtocol[]()

    init(args: ExpressionProtocol[]) {
        super.init()
        
        for expression in args {
            self.add(expression)
        }
    }

    convenience init(args: ExpressionProtocol...) {
        self.init(args: args)
    }
    
    /// Add a child expression to this operator.
    func add(expression: ExpressionProtocol) {
        _children.append(expression)
    }
    
    /// Fetch an array of this operator's children.
    func children() -> ExpressionProtocol[] {
        return _children
    }
}
