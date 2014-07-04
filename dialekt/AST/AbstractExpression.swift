// A base class providing common functionality for expressions.
//
// Partially implements ExpressionProtocol
class AbstractExpression {
    var _firstToken: Token?
    var _lastToken: Token?

    // Fetch the first token from the source that is part of this expression.
    func firstToken() -> Token? {
        return _firstToken
    }

    // Fetch the last token from the source that is part of this expression.
    func lastToken() -> Token? {
        return _lastToken
    }

    // Set the delimiting tokens for this expression.
    func setTokens(firstToken: Token, lastToken: Token) {
        _firstToken = firstToken
        _lastToken = lastToken
    }
}
