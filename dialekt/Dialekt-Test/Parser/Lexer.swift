public class Lexer: LexerProtocol {
	/// Tokenize an expression.
    public func lex(expression: String) -> [Token] {
		_currentOffset = 0
		_currentLine = 1
		_currentColumn = 0
		_state = .Begin
		_tokens = []
		_nextToken = nil
		_buffer = ""

		let length = expression.length()
		var currentChar: Character = "\0"
		var previousChar: Character = "\0"

        // TODO
        return []
    }

	private enum State {
        case Begin
        case SimpleString
        case QuotedString
        case QuotedStringEscape
	}

    private var _currentOffset: Int;
    private var _currentLine: Int;
    private var _currentColumn: Int;
    private var _state: State;
    private var _tokens: [Token];
    private var _nextToken: Token?;
    private var _buffer: String;
}
