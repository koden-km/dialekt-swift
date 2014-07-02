class AbstractParser: ParserProtocol {
    var _wildcardString = ""
    var _tokenStack = Token[]()
    var _tokens = Token[]()
    
    init() {
        setWildcardString(Token_WILDCARD_CHARACTER)
    }
    
    // Fetch the string to use as a wildcard placeholder.
    func wildcardString() -> String {
        return _wildcardString
    }
    
    // Set the string to use as a wildcard placeholder.
    func setWildcardString(wildcardString: String) {
        _wildcardString = wildcardString
    }
    
    // Parse an expression.
    func parse(expression: String, lexer: LexerProtocol?) -> ExpressionProtocol {
        var theLexer: Lexer
        if lexer {
            theLexer = lexer as Lexer
        } else {
            theLexer = Lexer()
        }
        
        return parseTokens(
            theLexer.lex(expression)
        )
    }
    
    // Parse an expression that has already beed tokenized.
    func parseTokens(tokens: Token[]) -> ExpressionProtocol {

        // TODO: finish this...
        
    }
}
