import Foundation

/// Parses a list of tags.
///
/// The expression must be a space-separated list of tags. The result is
/// either EmptyExpression, a single Tag node, or a LogicalAnd node
/// containing only Tag nodes.
public class ListParser: AbstractParser, ParserProtocol {

    /// Parse a list of tags into an array.
    ///
    /// The expression must be a space-separated list of tags. The result is
    /// an array of strings.
    public func parseAsArray(expression: String) -> [String]! {
        return parseAsArray(expression, lexer: Lexer())
    }

    /// Parse a list of tags into an array.
    ///
    /// The expression must be a space-separated list of tags. The result is
    /// an array of strings.
    public func parseAsArray(expression: String, lexer: LexerProtocol) -> [String]! {
        let result = parse(expression, lexer: lexer)
        if result == nil {
            return nil
        }

        var tags = [String]()
        if let logicalAndResult = result as? LogicalAnd {
            for child in logicalAndResult.children() {
                if let childTag = child as? Tag {
                    tags.append(childTag.name())
                }
            }
        } else if let tagResult = result as? Tag {
            tags.append(tagResult.name())
        }

        return tags
    }

    internal override func parseExpression() -> AbstractExpression! {
        let expression = LogicalAnd()

        startExpression()

        while _currentToken != nil {
            if !expectToken(TokenType.Text) {
                return nil
            }

            if _currentToken == nil || _currentToken.value.rangeOfString(wildcardString) != nil {
                // Implement a Result<T>/Failable<T> return type.
                // throw Exception "Unexpected wildcard string \"" + wildcardString + "\", in tag \"" + _currentToken.value + "\"."
				// fatalError("Unexpected wildcard string in tag.")
                return nil
            }

            let tag = Tag(_currentToken.value)

            startExpression()
            nextToken()
            endExpression(tag)

            expression.add(tag)
        }

        endExpression(expression)

        if expression.children().count == 1 {
            return expression.children()[0] as AbstractExpression
        }

        return expression
    }
}
