/// A base class providing common functionality for polyadic operators.
public class AbstractPolyadicExpression: AbstractExpression {
    public init(_ children: [ExpressionProtocol]) {
        _children = children

        super.init()
    }
    
    public convenience init(_ children: ExpressionProtocol...) {
        self.init(children)
    }
    
    /// Add a child expression to this operator.
    public func add(expression: ExpressionProtocol) {
        _children.append(expression)
    }
    
    /// Fetch an array of this operator's children.
    public func children() -> [ExpressionProtocol] {
        return _children
    }
    
    private var _children: [ExpressionProtocol]
}
