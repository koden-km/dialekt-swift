class ExpressionParser: AbstractParser {
    var logicalOrByDefault = false

    override func _parseExpression() -> ExpressionProtocol {
        _startExpression()

        var expression = _parseUnaryExpression()
        expression = _parseCompoundExpression(expression)

        _endExpression(expression)
        return expression
    }

    func _parseUnaryExpression() -> ExpressionProtocol {
        _expectToken(
            TokenType.Text,
            TokenType.LogicalNot,
            TokenType.OpenBracket
        )

        if TokenType.LogicalNot == _currentToken?.tokenType {
            return _parseLogicalNot()
        } else if TokenType.OpenBracket == _currentToken?.tokenType {
            return _parseNestedExpression()
// TODO
//        } else if false == strpos(_currentToken.value, _wildcardString()) {
//            return _parseTag()
        } else {
            return _parsePattern()
        }
    }

    func _parseTag() -> ExpressionProtocol {
        _startExpression()

        let expression = Tag(
            _currentToken!.value
        )

        _nextToken()

        _endExpression(expression)

        return expression
    }

    func _parsePattern() -> ExpressionProtocol {
        _startExpression()

// TODO
let parts = [String]()
//        $parts = preg_split(
//        '/(' . preg_quote($this->wildcardString(), '/') . ')/',
//        $this->currentToken->value,
//        -1,
//        PREG_SPLIT_DELIM_CAPTURE | PREG_SPLIT_NO_EMPTY
//        );

        let expression = Pattern()

        for value in parts {
            if wildcardString == value {
                expression.add(PatternWildcard())
            } else {
                expression.add(PatternLiteral(value))
            }
        }

        _nextToken()

        _endExpression(expression)

        return expression
    }

    func _parseNestedExpression() -> ExpressionProtocol {
        _startExpression()

        _nextToken()

        let expression = _parseExpression()

        _expectToken(TokenType.CloseBracket)

        _nextToken()

        _endExpression(expression)

        return expression
    }

    func _parseLogicalNot() -> ExpressionProtocol {
        _startExpression()

        _nextToken()

        let expression = LogicalNot(
            _parseUnaryExpression()
        )

        _endExpression(expression)

        return expression
    }

    func _parseCompoundExpression(expresison: ExpressionProtocol, minimumPrecedence: Int = 0) -> ExpressionProtocol {
        // TODO
        return expression
    }

    func _parseOperator() -> (operator: TokenType?, isExplicit: Bool) {
        // End of input ...
        if !_currentToken {
            return (nil, false)
        // Closing bracket ...
        } else if TokenType.CloseBracket == _currentToken?.tokenType {
            return (nil, false)
        // Explicit logical OR ...
        } else if TokenType.LogicalOr == _currentToken?.tokenType {
            return (TokenType.LogicalOr, true)
        // Explicit logical AND ...
        } else if TokenType.LogicalAnd == _currentToken?.tokenType {
            return (TokenType.LogicalAnd, true)
        // Implicit logical OR ...
        } else if logicalOrByDefault {
            return (TokenType.LogicalOr, false)
        // Implicit logical AND ...
        } else {
            return (TokenType.LogicalAnd, false)
        }
    }

    func _operatorPrecedence(operator: TokenType?) -> Int {
        if operator == TokenType.LogicalAnd {
            return 1
        } else if operator == TokenType.LogicalOr {
            return 0
        } else {
            return -1
        }
    }
}
