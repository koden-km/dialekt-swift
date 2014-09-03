public class AbstractParser {
    public var wildcardString: String

    public init(_ wildcardString: String) {
        self.wildcardString = wildcardString
        _tokenStack = []
        _tokens = []
        _tokenIndex = 0
    }

    public convenience init() {
        self.init(Token.WildcardString)
    }

    /// Parse an expression.
    public func parse(expression: String) -> AbstractExpression! {
        return parse(expression, lexer: Lexer())
    }

    /// Parse an expression using a specific lexer.
    public func parse(expression: String, lexer: LexerProtocol) -> AbstractExpression! {
        return parseTokens(
            lexer.lex(expression)
        )
    }

    /// Parse an expression that has already been tokenized.
    public func parseTokens(tokens: [Token]) -> AbstractExpression! {
        if (tokens.isEmpty) {
            return EmptyExpression()
        }

        _tokenStack.removeAll()
        _tokens = tokens
        _tokenIndex = 0
        _previousToken = nil
        _currentToken = tokens[0]

        let expression = parseExpression()
        if expression == nil {
            return nil
        }

        if _currentToken != nil {
            // Implement a Result<T>/Failable<T> return type.
            // throw ParseException "Unexpected " + _currentToken.tokenType.description + ", expected end of input."
            // fatalError("Unexpected token, expected end of input.")
            return nil
        }

        return expression
    }

    internal func parseExpression() -> AbstractExpression! {
        assert(false, "This method must be overriden.")
        return nil
    }

    internal func expectToken(types: TokenType...) -> Bool {
        if _currentToken == nil {
            // Implement a Result<T>/Failable<T> return type.
            // throw ParseException "Unexpected end of input, expected " + formatExpectedTokenNames(types) + "."
            // fatalError("Unexpected end of input, expected more tokens.")
            return false
        } else if !contains(types, _currentToken.tokenType) {
            // Implement a Result<T>/Failable<T> return type.
            // throw ParseException "Unexpected " + _currentToken.tokenType.description + ", expected " + formatExpectedTokenNames(types) + "."
            // fatalError("Unexpected token, expected other tokens.")
            return false
        }
        return true
    }

    internal func formatExpectedTokenNames(types: TokenType...) -> String {
        var result = types[0].description
        var index = 1

        if (types.count > 1) {
            for (; index < types.count; ++index) {
                result += ", " + types[index].description
            }
        }

        result += " or " + types[index].description

        return result
    }

    /// Advance to the next token.
    internal func nextToken() {
        _previousToken = _currentToken

        if ++_tokenIndex >= _tokens.count {
            _currentToken = nil
        } else {
            _currentToken = _tokens[_tokenIndex]
        }
    }

    /// Record the start of an expression.
    internal func startExpression() {
        _tokenStack.append(_currentToken)
    }

    /// Record the end of an expression.
    internal func endExpression(expression: ExpressionProtocol) {
        expression.setTokens(
            _tokenStack.removeLast(),
            _previousToken
        )
    }

    private var _tokenStack: [Token]
    private var _tokens: [Token]
    private var _tokenIndex: Int
    private var _previousToken: Token!

    internal var _currentToken: Token!
}
