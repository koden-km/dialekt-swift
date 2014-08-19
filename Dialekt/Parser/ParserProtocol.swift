public protocol ParserProtocol {
    func parse(expression: String) -> ExpressionProtocol
    func parse(expression: String, lexer: LexerProtocol) -> ExpressionProtocol
    func parseTokens(tokens: [Token]) -> ExpressionProtocol
}
