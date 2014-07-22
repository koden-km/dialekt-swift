/// A base class providing common functionality for expressions.
/// Partially implements ExpressionProtocol
public class AbstractExpression {
    /// Fetch the first token from the source that is part of this expression.
    public func firstToken() -> Token? {
        return _firstToken
    }

    /// Fetch the last token from the source that is part of this expression.
    public func lastToken() -> Token? {
        return _lastToken
    }

    /// Set the delimiting tokens for this expression.
    public func setTokens(firstToken: Token, lastToken: Token) {
        _firstToken = firstToken
        _lastToken = lastToken
    }

    private var _firstToken: Token? = nil
    private var _lastToken: Token? = nil
}
