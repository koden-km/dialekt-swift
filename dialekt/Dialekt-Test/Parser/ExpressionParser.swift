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
// TODO
//        } else if false == strpos(_currentToken.value, _wildcardString()) {
//            return _parseTag()
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

// TODO
let parts = [String]()
//NSRegularExpression.escapedPatternForString(wildcardString)
//        $parts = preg_split(
//        '/(' . preg_quote($this->wildcardString(), '/') . ')/',
//        $this->currentToken->value,
//        -1,
//        PREG_SPLIT_DELIM_CAPTURE | PREG_SPLIT_NO_EMPTY
//        )

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
        // TODO
        return expression
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
