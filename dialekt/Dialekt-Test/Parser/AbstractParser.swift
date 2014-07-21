class AbstractParser {
    var wildcardString: String

    init(_ wildcardString: String) {
        self.wildcardString = wildcardString
        _tokenStack = []
        _tokens = []
        _tokenIndex = 0
    }

    convenience init() {
        self.init(Token.WildcardString)
    }

    /// Parse an expression.
    func parse(expression: String) -> ExpressionProtocol {
        return parse(expression, lexer: Lexer())
    }

    /// Parse an expression using a specific lexer.
    func parse(expression: String, lexer: LexerProtocol) -> ExpressionProtocol {
        return parseTokens(
            lexer.lex(expression)
        )
    }

    /// Parse an expression that has already been tokenized.
    func parseTokens(tokens: [Token]) -> ExpressionProtocol {
        if (tokens.isEmpty) {
            return EmptyExpression()
        }

        _tokenStack.removeAll()
        _tokens = tokens
        _tokenIndex = 0
        _previousToken = nil
        _currentToken = tokens[0]

        let expression = _parseExpression()

        if (_currentToken) {
            // TODO: throw "Unexpected " + Token.typeDescription(this.currentToken.type) + ", expected end of input."
            fatalError("Unexpected token, expected end of input.")
        }

        return expression
    }

    func _parseExpression() -> ExpressionProtocol {
        assert(false, "This method must be overriden.")

        return EmptyExpression()
    }

    func _expectToken(types: TokenType...) {
        if !_currentToken {
            // TODO: throw "Unexpected end of input, expected " + this.formatExpectedTokenNames(types) + "."
            fatalError("Unexpected end of input, expected more tokens.")
        } else if !contains(types, _currentToken!.tokenType) {
            // TODO: throw "Unexpected " + Token.typeDescription(this.currentToken.type) + ", expected " + this.formatExpectedTokenNames(types) + "."
            fatalError("Unexpected token, expected other tokens.")
        }
    }

    func _formatExpectedTokenNames(types: TokenType...) -> String {
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
    func _nextToken() {
        _previousToken = _currentToken

        if ++_tokenIndex >= _tokens.count {
            _currentToken = nil
        } else {
            _currentToken = _tokens[_tokenIndex]
        }
    }

    /// Record the start of an expression.
    func _startExpression() {
        _tokenStack.append(_currentToken!)
    }

    /// Record the end of an expression.
    func _endExpression(expression: ExpressionProtocol) {
        expression.setTokens(
            _tokenStack.removeLast(),
            lastToken: _previousToken!
        )
    }

    var _tokenStack: [Token]
    var _tokens: [Token]
    var _tokenIndex: Int
    var _previousToken: Token?
    var _currentToken: Token?
}
