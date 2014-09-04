public class ExpressionParser: AbstractParser {
    public var logicalOrByDefault = false

    internal override func parseExpression() -> AbstractExpression! {
        startExpression()

        var expression = parseUnaryExpression()
        if expression != nil {
            expression = parseCompoundExpression(expression)
        }
        if expression == nil {
            return nil
        }

        endExpression(expression)

        return expression
    }

    private func parseUnaryExpression() -> AbstractExpression! {
        let foundExpected = expectToken(
            TokenType.Text,
            TokenType.LogicalNot,
            TokenType.OpenBracket
        )
        if !foundExpected {
            return nil
        }

        if TokenType.LogicalNot == _currentToken.tokenType {
            return parseLogicalNot()
        } else if TokenType.OpenBracket == _currentToken.tokenType {
            return parseNestedExpression()
        } else if _currentToken.value.rangeOfString(wildcardString, options: NSStringCompareOptions.LiteralSearch) == nil {
            return parseTag()
        } else {
            return parsePattern()
        }
    }

    private func parseTag() -> AbstractExpression {
        startExpression()

        let expression = Tag(
            _currentToken.value
        )

        nextToken()

        endExpression(expression)

        return expression
    }

    private func parsePattern() -> AbstractExpression {
        startExpression()

        // Note:
        // Could not get regex to escape wildcardString correctly for splitting with capture.
        // Using string split for now.
        let parts = _currentToken.value.componentsSeparatedByString(wildcardString)

        let expression = Pattern()

        if _currentToken.value.hasPrefix(wildcardString) {
            expression.add(PatternWildcard())
        }
        var chunks = parts.count - 1
        for value in parts {
            expression.add(PatternLiteral(value))
            if chunks > 1 {
                --chunks
                expression.add(PatternWildcard())
            }
        }
        if _currentToken.value.hasSuffix(wildcardString) {
            expression.add(PatternWildcard())
        }

        nextToken()

        endExpression(expression)

        return expression
    }

    private func parseNestedExpression() -> AbstractExpression! {
        startExpression()

        nextToken()

        let expression = parseExpression()
        if expression == nil {
            return nil
        }

        let foundExpected = expectToken(TokenType.CloseBracket)
        if !foundExpected {
            return nil
        }

        nextToken()

        endExpression(expression)

        return expression
    }

    private func parseLogicalNot() -> AbstractExpression {
        startExpression()

        nextToken()

        let expression = LogicalNot(
            parseUnaryExpression()
        )

        endExpression(expression)

        return expression
    }

    private func parseCompoundExpression(expression: ExpressionProtocol, minimumPrecedence: Int = 0) -> AbstractExpression! {
        var leftExpression = expression
        var allowCollapse = false

        while true {
            // Parse the operator and determine whether or not it's explicit ...
            let (oper, isExplicit) = parseOperator()

            let precedence = operatorPrecedence(oper)

            // Abort if the operator's precedence is less than what we're looking for ...
            if precedence < minimumPrecedence {
                break
            }

            // Advance the token pointer if an explicit operator token was found ...
            if isExplicit {
                nextToken()
            }

            // Parse the expression to the right of the operator ...
            var rightExpression = parseUnaryExpression()
            if rightExpression == nil {
                return nil
            }

            // Only parse additional compound expressions if their precedence is greater than the
            // expression already being parsed ...
            let (nextOperator, _) = parseOperator()

            if precedence < operatorPrecedence(nextOperator) {
                rightExpression = parseCompoundExpression(rightExpression, minimumPrecedence: precedence + 1)
                if rightExpression == nil {
                    return nil
                }
            }

            // Combine the parsed expression with the existing expression ...
            // Collapse the expression into an existing expression of the same type ...
            if oper == TokenType.LogicalAnd {
                if allowCollapse && leftExpression is LogicalAnd {
                    (leftExpression as LogicalAnd).add(rightExpression)
                } else {
                    leftExpression = LogicalAnd(leftExpression, rightExpression)
                    allowCollapse = true
                }
            } else if oper == TokenType.LogicalOr {
                if allowCollapse && leftExpression is LogicalOr {
                    (leftExpression as LogicalOr).add(rightExpression)
                } else {
                    leftExpression = LogicalOr(leftExpression, rightExpression)
                    allowCollapse = true
                }
            } else {
                fatalError("Unknown operator type.")
            }
        }

        return leftExpression as AbstractExpression
    }

    private func parseOperator() -> (oper: TokenType?, isExplicit: Bool) {
        // End of input ...
        if _currentToken == nil {
            return (nil, false)
        // Closing bracket ...
        } else if TokenType.CloseBracket == _currentToken.tokenType {
            return (nil, false)
        // Explicit logical OR ...
        } else if TokenType.LogicalOr == _currentToken.tokenType {
            return (TokenType.LogicalOr, true)
        // Explicit logical AND ...
        } else if TokenType.LogicalAnd == _currentToken.tokenType {
            return (TokenType.LogicalAnd, true)
        // Implicit logical OR ...
        } else if logicalOrByDefault {
            return (TokenType.LogicalOr, false)
        // Implicit logical AND ...
        } else {
            return (TokenType.LogicalAnd, false)
        }
    }

    private func operatorPrecedence(oper: TokenType?) -> Int {
        if oper == TokenType.LogicalAnd {
            return 1
        } else if oper == TokenType.LogicalOr {
            return 0
        } else {
            return -1
        }
    }
}
