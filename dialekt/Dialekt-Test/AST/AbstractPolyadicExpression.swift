/// A base class providing common functionality for polyadic operators.
class AbstractPolyadicExpression: AbstractExpression {
    var _children = [ExpressionProtocol]()
//    var _children = [Any]()

    init<T: ExpressionProtocol>(args: [T]) {
        super.init()
        
        for expression in args {
            self.add(expression)
        }
    }

    convenience init<T: ExpressionProtocol>(args: T...) {
        self.init(args: args)
    }
    
    /// Add a child expression to this operator.
    func add(expression: ExpressionProtocol) {
//    func add<T: ExpressionProtocol>(expression: T) {
        _children.append(expression)
    }
    
    /// Fetch an array of this operator's children.
    func children() -> [ExpressionProtocol] {
//    func children<T: ExpressionProtocol>() -> [T] {
//    func children<T: [ExpressionProtocol]>() -> T {
//    func children() -> [Any] {
        return _children
    }
}
