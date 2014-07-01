protocol ParserProtocol {
    // Parse an expression.
    func parse(expresion: ExpressionProtocol, lexer: LexerProtocol) -> ExpressionProtocol
    
    // Parse an expression that has already beed tokenized.
    func parseTokens(tokens: Token[]) -> ExpressionProtocol
}
