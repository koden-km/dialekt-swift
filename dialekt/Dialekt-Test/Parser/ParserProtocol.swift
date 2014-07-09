protocol ParserProtocol {
    /// Parse an expression.
    func parse<R: ExpressionProtocol>(expression: String, lexer: LexerProtocol?) -> R
    
    /// Parse an expression that has already beed tokenized.
    func parseTokens<R: ExpressionProtocol>(tokens: [Token]) -> R
}
