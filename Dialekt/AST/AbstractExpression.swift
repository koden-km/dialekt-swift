/// A base class providing common functionality for expressions.
/// Partially implements ExpressionProtocol
public class AbstractExpression: ExpressionProtocol {
    public init() {
        _hashValue = HashSequence.next()
    }

    /// Fetch the first token from the source that is part of this expression.
    public func firstToken() -> Token? {
        return _firstToken
    }

    /// Fetch the last token from the source that is part of this expression.
    public func lastToken() -> Token? {
        return _lastToken
    }

    /// Set the delimiting tokens for this expression.
    public func setTokens(firstToken: Token, _ lastToken: Token) {
        _firstToken = firstToken
        _lastToken = lastToken
    }

    // Required to confrom to ExpressionProtocol.
    public func accept<T: VisitorProtocol>(visitor: T) -> T.VisitorResultType {
        fatalError("This method must be overriden.")
        return visitor.visit(EmptyExpression()) as T.VisitorResultType
    }

    // Required to confrom to ExpressionProtocol.
    public func accept<T: ExpressionVisitorProtocol>(visitor: T) -> T.ExpressionVisitorResultType {
        fatalError("This method must be overriden.")
        return visitor.visit(EmptyExpression())
    }

    private var _firstToken: Token? = nil
    private var _lastToken: Token? = nil
    private var _hashValue: Int = 0

    internal struct HashSequence {
        private static var _nextHash = 0
        internal static func next() -> Int {
            return ++_nextHash
        }
    }
}

/// MARK: Equatable

extension AbstractExpression: Equatable {
}

public func ==(lhs: AbstractExpression, rhs: AbstractExpression) -> Bool {
    return lhs === rhs
}

/// MARK: Hashable

extension AbstractExpression: Hashable {
    public var hashValue: Int {
        return self._hashValue
    }
}
