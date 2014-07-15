protocol ParserProtocol {
    /// Parse an expression.
    func parse(expression: String, lexer: LexerProtocol?) -> ExpressionProtocol
//    func parse<R: ExpressionProtocol>(expression: String, lexer: LexerProtocol?) -> R
    
    /// Parse an expression that has already beed tokenized.
    func parseTokens(tokens: [Token]) -> ExpressionProtocol
//    func parseTokens<R: ExpressionProtocol>(tokens: [Token]) -> R
}
