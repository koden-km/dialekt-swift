import XCTest
import Dialekt

class LexerTest: XCTestCase {

    var lexer: Lexer!

    override func setUp() {
        super.setUp()

        self.lexer = Lexer()
    }

    func testLex() {
        for testVector in self.lexTestVectors() {
            let result = self.lexer.lex(testVector.expression)

            XCTAssertEqual(testVector.expected, result, testVector.name)
        }
    }

    func testPerformanceLex() {
        self.measureBlock() {
            for testVector in self.lexTestVectors() {
                let result = self.lexer.lex(testVector.expression)
            }
        }
    }

    func lexTestVectors() -> [LexTestVector] {
        return [
            LexTestVector(
                name: "empty expression",
                expression: "",
                expected: [Token]()
            ),
            LexTestVector(
                name: "whitespace only",
                expression: " \n \t ",
                expected: [Token]()
            ),
            LexTestVector(
                name: "simple string",
                expression: "foo-bar",
                expected: [
                    Token(TokenType.Text, "foo-bar", 0, 7, 1, 1),
                ]
            ),
            LexTestVector(
                name: "simple string with leading hyphen",
                expression: "-foo",
                expected: [
                    Token(TokenType.Text, "-foo", 0, 4, 1, 1),
                ]
            ),
            LexTestVector(
                name: "simple string with leading hyphen and asterisk",
                expression: "-foo*-",
                expected: [
                    Token(TokenType.Text, "-foo*-", 0, 6, 1, 1),
                ]
            ),
            LexTestVector(
                name: "multiple simple strings",
                expression: "foo bar",
                expected: [
                    Token(TokenType.Text, "foo", 0, 3, 1, 1),
                    Token(TokenType.Text, "bar", 4, 7, 1, 5),
                ]
            ),
            LexTestVector(
                name: "quoted string",
                expression: "\"foo bar\"",
                expected: [
                    Token(TokenType.Text, "foo bar", 0, 9, 1, 1),
                ]
            ),
            LexTestVector(
                name: "quoted string with escaped quote",
                expression: "\"foo \\\"the\\\" bar\"",
                expected: [
                    Token(TokenType.Text, "foo \"the\" bar", 0, 17, 1, 1),
                ]
            ),
            LexTestVector(
                name: "quoted string with escaped backslash",
                expression: "\"foo\\\\bar\"",
                expected: [
                    Token(TokenType.Text, "foo\\bar", 0, 10, 1, 1),
                ]
            ),
            LexTestVector(
                name: "logical and",
                expression: "and",
                expected: [
                    Token(TokenType.LogicalAnd, "and", 0, 3, 1, 1),
                ]
            ),
            LexTestVector(
                name: "logical or",
                expression: "or",
                expected: [
                    Token(TokenType.LogicalOr, "or", 0, 2, 1, 1),
                ]
            ),
            LexTestVector(
                name: "logical not",
                expression: "not",
                expected: [
                    Token(TokenType.LogicalNot, "not", 0, 3, 1, 1),
                ]
            ),
            LexTestVector(
                name: "logical operator case insensitivity",
                expression: "aNd Or NoT",
                expected: [
                    Token(TokenType.LogicalAnd, "aNd", 0, 3,  1, 1),
                    Token(TokenType.LogicalOr,  "Or",  4, 6,  1, 5),
                    Token(TokenType.LogicalNot, "NoT", 7, 10, 1, 8),
                ]
            ),
            LexTestVector(
                name: "open nesting",
                expression: "(",
                expected: [
                    Token(TokenType.OpenBracket, "(", 0, 1, 1, 1),
                ]
            ),
            LexTestVector(
                name: "close nesting",
                expression: ")",
                expected: [
                    Token(TokenType.CloseBracket, ")", 0, 1, 1, 1),
                ]
            ),
            LexTestVector(
                name: "nesting interrupts simple string",
                expression: "foo(bar)spam",
                expected: [
                    Token(TokenType.Text,         "foo",  0, 3,  1, 1),
                    Token(TokenType.OpenBracket,  "(",    3, 4,  1, 4),
                    Token(TokenType.Text,         "bar",  4, 7,  1, 5),
                    Token(TokenType.CloseBracket, ")",    7, 8,  1, 8),
                    Token(TokenType.Text,         "spam", 8, 12, 1, 9),
                ]
            ),
            LexTestVector(
                name: "nesting interrupts simple string into quoted string",
                expression: "foo(bar)\"spam\"",
                expected: [
                    Token(TokenType.Text,         "foo",  0, 3,  1, 1),
                    Token(TokenType.OpenBracket,  "(",    3, 4,  1, 4),
                    Token(TokenType.Text,         "bar",  4, 7,  1, 5),
                    Token(TokenType.CloseBracket, ")",    7, 8,  1, 8),
                    Token(TokenType.Text,         "spam", 8, 14, 1, 9),
                ]
            ),
            LexTestVector(
                name: "whitespace surrounding strings",
                expression: " \t\nfoo\tbar\nspam\t ",
                expected: [
                    Token(TokenType.Text, "foo",   3, 6,  2, 1),
                    Token(TokenType.Text, "bar",   7, 10, 2, 5),
                    Token(TokenType.Text, "spam", 11, 15, 3, 1),
                ]
            ),
            LexTestVector(
                name: "newline handling",
                expression: "\"foo\nbar\" baz",
                expected: [
                    Token(TokenType.Text, "foo\nbar",  0,  9, 1, 1),
                    Token(TokenType.Text, "baz",      10, 13, 2, 6),
                ]
            ),
            LexTestVector(
                name: "carriage return handling",
                expression: "\"foo\rbar\" baz",
                expected: [
                    Token(TokenType.Text, "foo\rbar",  0,  9, 1, 1),
                    Token(TokenType.Text, "baz",      10, 13, 2, 6),
                ]
            ),
            LexTestVector(
                name: "carriage return + newline handling",
                expression: "\"foo\r\nbar\" baz",
                expected: [
                    Token(TokenType.Text, "foo\r\nbar",  0, 10, 1, 1),
                    Token(TokenType.Text, "baz",        11, 14, 2, 6),
                ]
            )
        ]
    }

    class LexTestVector {
        var name: String
        var expression: String
        var expected: [Token]

        init(name: String, expression: String, expected: [Token]) {
            self.name = name
            self.expression = expression
            self.expected = expected
        }
    }
}
