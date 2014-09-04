import XCTest
import Dialekt

class TreeRendererTest: XCTestCase {

    var renderer: TreeRenderer!

    override func setUp() {
        super.setUp()

        self.renderer = TreeRenderer(endOfLine: "\r\n")
    }

    func testConstructor() {
        XCTAssertEqual("\r\n", self.renderer.endOfLine())
    }

    func testConstructorDefaults() {
        self.renderer = TreeRenderer()
        XCTAssertEqual("\n", self.renderer.endOfLine())
    }

    func testRender() {
        for testVector in self.renderTestVectors() {
            let string = self.renderer.render(testVector.expression)

            XCTAssertEqual(testVector.expected, string, testVector.name)
        }
    }

    func testPerformanceRender() {
        self.measureBlock() {
            for testVector in self.renderTestVectors() {
                let string = self.renderer.render(testVector.expression)
            }
        }
    }

    func renderTestVectors() -> [RenderTestVector] {
        return [
            RenderTestVector(
                name: "empty expression",
                expression: EmptyExpression(),
                expected: "EMPTY"
            ),
            RenderTestVector(
                name: "tag",
                expression: Tag("foo"),
                expected: "TAG \"foo\""
            ),
            RenderTestVector(
                name: "escaped tag",
                expression: Tag("f\\o\"o"),
                expected: "TAG \"f\\\\o\\\"o\""
            ),
            RenderTestVector(
                name: "escaped tag - logical and",
                expression: Tag("and"),
                expected: "TAG \"and\""
            ),
            RenderTestVector(
                name: "escaped tag - logical or",
                expression: Tag("or"),
                expected: "TAG \"or\""
            ),
            RenderTestVector(
                name: "escaped tag - logical not",
                expression: Tag("not"),
                expected: "TAG \"not\""
            ),
            RenderTestVector(
                name: "tag with spaces",
                expression: Tag("foo bar"),
                expected: "TAG \"foo bar\""
            ),
            RenderTestVector(
                name: "pattern",
                expression: Dialekt.Pattern(
                    PatternLiteral("foo"),
                    PatternWildcard()
                ),
                expected:
                    "PATTERN\r\n" +
                    "  - LITERAL \"foo\"\r\n" +
                    "  - WILDCARD"
            ),
            RenderTestVector(
                name: "escaped pattern",
                expression: Dialekt.Pattern(
                    PatternLiteral("foo\""),
                    PatternWildcard()
                ),
                expected:
                    "PATTERN\r\n" +
                    "  - LITERAL \"foo\\\"\"\r\n" +
                    "  - WILDCARD"
            ),
            RenderTestVector(
                name: "logical and",
                expression: LogicalAnd(
                    Tag("a"),
                    Tag("b"),
                    Tag("c")
                ),
                expected:
                    "AND\r\n" +
                    "  - TAG \"a\"\r\n" +
                    "  - TAG \"b\"\r\n" +
                    "  - TAG \"c\""
            ),
            RenderTestVector(
                name: "logical or",
                expression: LogicalOr(
                    Tag("a"),
                    Tag("b"),
                    Tag("c")
                ),
                expected:
                    "OR\r\n" +
                    "  - TAG \"a\"\r\n" +
                    "  - TAG \"b\"\r\n" +
                    "  - TAG \"c\""
            ),
            RenderTestVector(
                name: "logical not",
                expression: LogicalNot(
                    Tag("a")
                ),
                expected:
                    "NOT\r\n" +
                    "  - TAG \"a\""
            )
        ]
    }

    class RenderTestVector {
        var name: String
        var expression: ExpressionProtocol
        var expected: String

        init(name: String, expression: ExpressionProtocol, expected: String) {
            self.name = name
            self.expression = expression
            self.expected = expected
        }
    }
}
