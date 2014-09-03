public protocol ParserProtocol {
    func parse(expression: String) -> AbstractExpression!
    func parse(expression: String, lexer: LexerProtocol) -> AbstractExpression!
    func parseTokens(tokens: [Token]) -> AbstractExpression!
}
