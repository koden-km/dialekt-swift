import Foundation

public class ExpressionParser: AbstractParser {
    public var logicalOrByDefault = false

    internal override func parseExpression() -> ExpressionProtocol {
        startExpression()

        var expression = parseUnaryExpression()
        expression = parseCompoundExpression(expression)

        endExpression(expression)
        return expression
    }

    private func parseUnaryExpression() -> ExpressionProtocol {
        expectToken(
            TokenType.Text,
            TokenType.LogicalNot,
            TokenType.OpenBracket
        )

        if TokenType.LogicalNot == _currentToken?.tokenType {
            return parseLogicalNot()
        } else if TokenType.OpenBracket == _currentToken?.tokenType {
            return parseNestedExpression()
        } else if _currentToken?.value.rangeOfString(wildcardString, options: NSStringCompareOptions.LiteralSearch) == nil {
            return parseTag()
        } else {
            return parsePattern()
        }
    }

    private func parseTag() -> ExpressionProtocol {
        startExpression()

        let expression = Tag(
            _currentToken!.value
        )

        nextToken()

        endExpression(expression)

        return expression
    }

    private func parsePattern() -> ExpressionProtocol {
        startExpression()

        let pattern = "/(" + NSRegularExpression.escapedPatternForString(wildcardString) + ")/"
        let regex = NSRegularExpression.regularExpressionWithPattern(
            pattern,
            options: NSRegularExpressionOptions(0),
            error: nil
        )

        let parts = regex.matchesInString(
            _currentToken!.value,
            options: NSMatchingOptions.Anchored,
            range: NSRangeFromString(_currentToken!.value)
        ) as [String]

        let expression = Pattern()

        for value in parts {
            if wildcardString == value {
                expression.add(PatternWildcard())
            } else {
                expression.add(PatternLiteral(value))
            }
        }

        nextToken()

        endExpression(expression)

        return expression
    }

    private func parseNestedExpression() -> ExpressionProtocol {
        startExpression()

        nextToken()

        let expression = parseExpression()

        expectToken(TokenType.CloseBracket)

        nextToken()

        endExpression(expression)

        return expression
    }

    private func parseLogicalNot() -> ExpressionProtocol {
        startExpression()

        nextToken()

        let expression = LogicalNot(
            parseUnaryExpression()
        )

        endExpression(expression)

        return expression
    }

    private func parseCompoundExpression(expresison: ExpressionProtocol, minimumPrecedence: Int = 0) -> ExpressionProtocol {
        var leftExpresison = expression
        var allowCollapse = false

        while true {
            // Parse the operator and determine whether or not it's explicit ...
            let (operator, isExplicit) = parseOperator()

            let precedence = operatorPrecedence(operator)

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

            // Only parse additional compound expressions if their precedence is greater than the
            // expression already being parsed ...
            let (nextOperator, _) = parseOperator()

            if precedence < operatorPrecedence(nextOperator) {
                rightExpression = parseCompoundExpression(rightExpression, minimumPrecedence: precedence + 1)
            }

            // Combine the parsed expression with the existing expression ...
            // Collapse the expression into an existing expression of the same type ...
            if allowCollapse && operator == TokenType.LogicalAnd && leftExpresison is LogicalAnd {
                (leftExpresison as LogicalAnd).add(rightExpression)
            } else if operator == TokenType.LogicalOr {
                leftExpresison = LogicalOr(leftExpresison, rightExpression)
                allowCollapse = true
            } else {
                fatalError("Operator class not supported.")
            }
        }

        return leftExpresison
    }

    private func parseOperator() -> (operator: TokenType?, isExplicit: Bool) {
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

    private func operatorPrecedence(operator: TokenType?) -> Int {
        if operator == TokenType.LogicalAnd {
            return 1
        } else if operator == TokenType.LogicalOr {
            return 0
        } else {
            return -1
        }
    }
}
