import XCTest
import Dialekt

class ExpressionParserTest: XCTestCase {

    var renderer: ExpressionRenderer!
    var parser: ExpressionParser!

    override func setUp() {
        super.setUp()

        self.renderer = ExpressionRenderer()
        self.parser = ExpressionParser()
    }

    func testParse() {
        for testVector in self.parseTestVectors() {
            let result = self.parser.parse(testVector.expression)

            XCTAssertEqual(
                self.renderer.render(testVector.expected),
                self.renderer.render(result),
                testVector.name
            )
        }
    }

    func testPerformanceParse() {
        self.measureBlock() {
            for testVector in self.parseTestVectors() {
                let result = self.parser.parse(testVector.expression)
            }
        }
    }

    func testParseFailure() {
        for testVector in self.parseFailureTestVectors() {
            let result = self.parser.parse(testVector.expression)
            XCTAssertNil(result, testVector.name)
        }
    }

    func testParseUsingLogicalOrAsDefaultOperator() {
        self.parser.logicalOrByDefault = true

        let result = self.parser.parse("a and b c and d")
        XCTAssertEqual(
            "((a AND b) OR (c AND d))",
            self.renderer.render(result)
        )
    }

    func testParseWithSourceCapture() {
        let lexer = Lexer()
        let tokens = lexer.lex("a AND (b OR c) AND NOT p*")
        let result = self.parser.parseTokens(tokens)

        XCTAssertEqual(tokens[0], result.firstToken())
        XCTAssertEqual(tokens[9], result.lastToken())

        if let resultAbstractPolyadicExpression = result as? AbstractPolyadicExpression {
            let children = resultAbstractPolyadicExpression.children()
            var node: ExpressionProtocol

            node = children[0]
            XCTAssertEqual(tokens[0], node.firstToken())
            XCTAssertEqual(tokens[0], node.lastToken())

            node = children[1]
            XCTAssertEqual(tokens[2], node.firstToken())
            XCTAssertEqual(tokens[6], node.lastToken())

            node = children[2]
            XCTAssertEqual(tokens[8], node.firstToken())
            XCTAssertEqual(tokens[9], node.lastToken())

            if let childLogicalNot = children[2] as? LogicalNot {
                node = childLogicalNot.child()
                XCTAssertEqual(tokens[9], node.firstToken())
                XCTAssertEqual(tokens[9], node.lastToken())
            } else {
                XCTAssertTrue(false, "Expected child to be a LogicalNot.")
            }

            if let childAbstractPolyadicExpression = children[1] as? AbstractPolyadicExpression {
                let subChildren = childAbstractPolyadicExpression.children()

                node = subChildren[0]
                XCTAssertEqual(tokens[3], node.firstToken())
                XCTAssertEqual(tokens[3], node.lastToken())

                node = subChildren[1]
                XCTAssertEqual(tokens[5], node.firstToken())
                XCTAssertEqual(tokens[5], node.lastToken())
            } else {
                XCTAssertTrue(false, "Expected child to be an AbstractPolyadicExpression.")
            }
        } else {
            XCTAssertTrue(false, "Expected result to be an AbstractPolyadicExpression.")
        }
    }

    func parseTestVectors() -> [ParserTestVector] {
        return [
            ParserTestVector(
                name: "empty expression",
                expression: "",
                expected: EmptyExpression()
            ),
            ParserTestVector(
                name: "single tag",
                expression: "a",
                expected: Tag("a")
            ),
            ParserTestVector(
                name: "tag pattern",
                expression: "a*",
                expected: Dialekt.Pattern(
                    PatternLiteral("a"),
                    PatternWildcard()
                )
            ),
            ParserTestVector(
                name: "multiple tags two",
                expression: "a b",
                expected: LogicalAnd(
                    Tag("a"),
                    Tag("b")
                )
            ),
            ParserTestVector(
                name: "multiple tags many",
                expression: "a b c",
                expected: LogicalAnd(
                    Tag("a"),
                    Tag("b"),
                    Tag("c")
                )
            ),
            ParserTestVector(
                name: "multiple tags with nesting",
                expression: "a (b c)",
                expected: LogicalAnd(
                    Tag("a"),
                    LogicalAnd(
                        Tag("b"),
                        Tag("c")
                    )
                )
            ),
            ParserTestVector(
                name: "multiple nested groups remain nested",
                expression: "(a b) (c d)",
                expected: LogicalAnd(
                    LogicalAnd(
                        Tag("a"),
                        Tag("b")
                    ),
                    LogicalAnd(
                        Tag("c"),
                        Tag("d")
                    )
                )
            ),
            ParserTestVector(
                name: "logical and",
                expression: "a AND b",
                expected: LogicalAnd(
                    Tag("a"),
                    Tag("b")
                )
            ),
            ParserTestVector(
                name: "logical and chained",
                expression: "a AND b AND c",
                expected: LogicalAnd(
                    Tag("a"),
                    Tag("b"),
                    Tag("c")
                )
            ),
            ParserTestVector(
                name: "Logical or",
                expression: "a OR b",
                expected: LogicalOr(
                    Tag("a"),
                    Tag("b")
                )
            ),
            ParserTestVector(
                name: "logical or chained",
                expression: "a OR b OR c",
                expected: LogicalOr(
                    Tag("a"),
                    Tag("b"),
                    Tag("c")
                )
            ),
            ParserTestVector(
                name: "logical not",
                expression: "NOT a",
                expected: LogicalNot(
                    Tag("a")
                )
            ),
            ParserTestVector(
                name: "Logical not chained",
                expression: "NOT NOT a",
                expected: LogicalNot(
                    LogicalNot(
                        Tag("a")
                    )
                )
            ),
            ParserTestVector(
                name: "logical operator implicit precedence 1",
                expression: "a OR b AND c",
                expected: LogicalOr(
                    Tag("a"),
                    LogicalAnd(
                        Tag("b"),
                        Tag("c")
                    )
                )
            ),
            ParserTestVector(
                name: "logical operator implicit precedence 2",
                expression: "a AND b OR c",
                expected: LogicalOr(
                    LogicalAnd(
                        Tag("a"),
                        Tag("b")
                    ),
                    Tag("c")
                )
            ),
            ParserTestVector(
                name: "logical operator explicit precedence 1",
                expression: "(a OR b) AND c",
                expected: LogicalAnd(
                    LogicalOr(
                        Tag("a"),
                        Tag("b")
                    ),
                    Tag("c")
                )
            ),
            ParserTestVector(
                name: "logical operator explicit precedence 2",
                expression: "a AND (b OR c)",
                expected: LogicalAnd(
                    Tag("a"),
                    LogicalOr(
                        Tag("b"),
                        Tag("c")
                    )
                )
            ),
            ParserTestVector(
                name: "logical not implicit precedence",
                expression: "NOT a AND b",
                expected: LogicalAnd(
                    LogicalNot(
                        Tag("a")
                    ),
                    Tag("b")
                )
            ),
            ParserTestVector(
                name: "logical not explicit precedence",
                expression: "NOT (a AND b)",
                expected: LogicalNot(
                    LogicalAnd(
                        Tag("a"),
                        Tag("b")
                    )
                )
            ),
            ParserTestVector(
                name: "complex nested",
                expression: "a ((b OR c) AND (d OR e)) f",
                expected: LogicalAnd(
                    Tag("a"),
                    LogicalAnd(
                        LogicalOr(
                            Tag("b"),
                            Tag("c")
                        ),
                        LogicalOr(
                            Tag("d"),
                            Tag("e")
                        )
                    ),
                    Tag("f")
                )
            )
        ]
    }

    func parseFailureTestVectors() -> [ParserFailureTestVector] {
        return [
            ParserFailureTestVector(
                name: "leading logical and",
                expression: "AND a",
                expectedMessage: "Unexpected AND operator, expected tag, NOT operator or open bracket."
            ),
            ParserFailureTestVector(
                name: "leading logical or",
                expression: "OR a",
                expectedMessage: "Unexpected OR operator, expected tag, NOT operator or open bracket."
            ),
            ParserFailureTestVector(
                name: "trailing logical and",
                expression: "a AND",
                expectedMessage: "Unexpected end of input, expected tag, NOT operator or open bracket."
            ),
            ParserFailureTestVector(
                name: "trailing logical or",
                expression: "a OR",
                expectedMessage: "Unexpected end of input, expected tag, NOT operator or open bracket."
            ),
            ParserFailureTestVector(
                name: "mismatched braces 1",
                expression: "(a",
                expectedMessage: "Unexpected end of input, expected close bracket."
            ),
            ParserFailureTestVector(
                name: "mismatched braces 2",
                expression: "a)",
                expectedMessage: "Unexpected close bracket, expected end of input."
            )
        ]
    }

    class ParserTestVector {
        var name: String
        var expression: String
        var expected: ExpressionProtocol

        init(name: String, expression: String, expected: ExpressionProtocol) {
            self.name = name
            self.expression = expression
            self.expected = expected
        }
    }

    // The expectedMessage is currently unused. Need to implement a kind of Result or Failable to return error message.
    // Waiting to see if Swift gets an official error handling pattern.
    class ParserFailureTestVector {
        var name: String
        var expression: String
        var expectedMessage: String

        init(name: String, expression: String, expectedMessage: String) {
            self.name = name
            self.expression = expression
            self.expectedMessage = expectedMessage
        }
    }
}
