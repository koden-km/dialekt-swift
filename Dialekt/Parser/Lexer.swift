import Foundation

public class Lexer: LexerProtocol {
    public init() {
        _currentOffset = 0
        _currentLine = 1
        _currentColumn = 0
        _state = .Begin
        _tokens = []
        _nextToken = nil
        _buffer = ""
    }

    /// Tokenize an expression.
    public func lex(expression: String) -> [Token]! {
		_currentOffset = 0
		_currentLine = 1
		_currentColumn = 0
		_state = .Begin
		_tokens = []
		_nextToken = nil
		_buffer = ""

		var currentChar: Character = "\0"
		var previousChar: Character = "\0"

        for unicodeScalar in expression.unicodeScalars {
            currentChar = Character(unicodeScalar)

            _currentColumn++

            if "\n" == previousChar || ("\r" == previousChar && "\n" != currentChar) {
                _currentLine++
                _currentColumn = 1
            }

            switch _state {
            case .SimpleString:
                handleSimpleStringState(currentChar)
            case .QuotedString:
                handleQuotedStringState(currentChar)
            case .QuotedStringEscape:
                handleQuotedStringEscapeState(currentChar)
            case .Begin:
                handleBeginState(currentChar)
            }

            _currentOffset++
            previousChar = currentChar
        }

        if _state == State.SimpleString {
            finalizeSimpleString()
        } else if _state == State.QuotedString {
            // Implement a Result<T>/Failable<T> return type.
            // throw ParseException "Expected closing quote."
            // fatalError("Expected closing quote.")
            return nil
        } else if _state == State.QuotedStringEscape {
            // Implement a Result<T>/Failable<T> return type.
            // throw ParseException "Expected character after backslash."
            // fatalError("Expected character after backslash.")
            return nil
        }

        return _tokens
    }

    private func handleBeginState(currentChar: Character) {
        if characterIsWhitespace(currentChar) {
            // ignore ...
        } else if currentChar == "(" {
            startToken(TokenType.OpenBracket)
            endToken(currentChar)
        } else if currentChar == ")" {
            startToken(TokenType.CloseBracket)
            endToken(currentChar)
        } else if currentChar == "\"" {
            startToken(TokenType.Text)
            _state = State.QuotedString
        } else {
            startToken(TokenType.Text)
            _state = State.SimpleString
            _buffer = String(currentChar)
        }
    }

    private func handleSimpleStringState(currentChar: Character) {
        if characterIsWhitespace(currentChar) {
            finalizeSimpleString()
        } else if currentChar == "(" {
            finalizeSimpleString()
            startToken(TokenType.OpenBracket)
            endToken(currentChar)
        } else if currentChar == ")" {
            finalizeSimpleString()
            startToken(TokenType.CloseBracket)
            endToken(currentChar)
        } else {
            _buffer.append(currentChar)
        }
    }

    private func handleQuotedStringState(currentChar: Character) {
        if currentChar == "\\" {
            _state = State.QuotedStringEscape
        } else if currentChar == "\"" {
            endToken(_buffer)
            _state = State.Begin
            _buffer = ""
        } else {
            _buffer.append(currentChar)
        }
    }

    private func handleQuotedStringEscapeState(currentChar: Character) {
        _state = .QuotedString
        _buffer.append(currentChar)
    }

    private func finalizeSimpleString() {
        let bufferLowercase = _buffer.lowercaseString
        if bufferLowercase == "and" {
            _nextToken!.tokenType = TokenType.LogicalAnd
        } else if bufferLowercase == "or" {
            _nextToken!.tokenType = TokenType.LogicalOr
        } else if bufferLowercase == "not" {
            _nextToken!.tokenType = TokenType.LogicalNot
        }

        endToken(_buffer, lengthAdjustment: -1)
        _state = State.Begin
        _buffer = ""
    }

    private func startToken(type: TokenType) {
        _nextToken = Token(
            type,
            "",
            _currentOffset,
            0,
            _currentLine,
            _currentColumn
        )
    }

    private func endToken(value: String, lengthAdjustment: Int) {
        _nextToken!.value = value
        _nextToken!.endOffset = _currentOffset + lengthAdjustment + 1
        _tokens.append(_nextToken!)
        _nextToken = nil
    }

    private func endToken(value: String) {
        endToken(value, lengthAdjustment: 0)
    }

    private func endToken(value: Character) {
        endToken(String(value), lengthAdjustment: 0)
    }

	private enum State {
        case Begin
        case SimpleString
        case QuotedString
        case QuotedStringEscape
	}

    private func characterIsWhitespace(character: Character) -> Bool {
        let result = String(character).stringByTrimmingCharactersInSet(
            NSCharacterSet.whitespaceAndNewlineCharacterSet()
        )
        return result.isEmpty
    }

    private var _currentOffset: Int
    private var _currentLine: Int
    private var _currentColumn: Int
    private var _state: State
    private var _tokens: [Token]
    private var _nextToken: Token?
    private var _buffer: String
}
