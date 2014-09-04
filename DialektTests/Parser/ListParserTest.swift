import XCTest
import Dialekt

class ListParserTest: XCTestCase {

    var renderer: ExpressionRenderer!
    var parser: ListParser!

    override func setUp() {
        super.setUp()

        self.renderer = ExpressionRenderer()
        self.parser = ListParser()
    }

    func testParse() {
        for testVector in self.parseTestVectors() {
            let result = self.parser.parse(testVector.expression)

            XCTAssertEqual(
                self.renderer.render(testVector.expectedResult),
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

    func testParseAsArray() {
        for testVector in self.parseTestVectors() {
            let result = self.parser.parseAsArray(testVector.expression)

            XCTAssertEqual(
                testVector.expectedTags,
                result,
                testVector.name
            )
        }
    }

    func testPerformanceParseAsArray() {
        self.measureBlock() {
            for testVector in self.parseTestVectors() {
                let result = self.parser.parseAsArray(testVector.expression)
            }
        }
    }

    func testParseFailureWithNonString() {
        let result = self.parser.parse("and")
        XCTAssertNil(result)
    }

    func testParseFailureWithWildcardCharacter() {
        let result = self.parser.parse("foo*")
        XCTAssertNil(result)
    }

    func testTokens() {
        let lexer = Lexer()
        let tokens = lexer.lex("a b c")
        let result = self.parser.parseTokens(tokens) as LogicalAnd

        XCTAssertEqual(tokens[0], result.firstToken())
        XCTAssertEqual(tokens[2], result.lastToken())

        let children = result.children()

        var node: ExpressionProtocol

        node = children[0]
        XCTAssertEqual(tokens[0], node.firstToken())
        XCTAssertEqual(tokens[0], node.lastToken())

        node = children[1]
        XCTAssertEqual(tokens[1], node.firstToken())
        XCTAssertEqual(tokens[1], node.lastToken())

        node = children[2]
        XCTAssertEqual(tokens[2], node.firstToken())
        XCTAssertEqual(tokens[2], node.lastToken())
    }

    func parseTestVectors() -> [ParserTestVector] {
        return [
            ParserTestVector(
                name: "empty expression",
                expression: "",
                expectedResult: EmptyExpression(),
                expectedTags: [String]()
            ),
            ParserTestVector(
                name: "single tag",
                expression: "foo",
                expectedResult:Tag("foo"),
                expectedTags: ["foo"]
            ),
            ParserTestVector(
                name: "multiple tags",
                expression: "foo \"bar spam\"",
                expectedResult: LogicalAnd(
                    Tag("foo"),
                    Tag("bar spam")
                ),
                expectedTags: ["foo", "bar spam"]
            )
        ]
    }

    class ParserTestVector {
        var name: String
        var expression: String
        var expectedResult: ExpressionProtocol
        var expectedTags: [String]

        init(name: String, expression: String, expectedResult: ExpressionProtocol, expectedTags: [String]) {
            self.name = name
            self.expression = expression
            self.expectedResult = expectedResult
            self.expectedTags = expectedTags
        }
    }
}
