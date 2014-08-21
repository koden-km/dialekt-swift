import XCTest
import Dialekt

class ExpressionRendererTest: XCTestCase {

    var renderer: ExpressionRenderer!

    override func setUp() {
        super.setUp()

        self.renderer = ExpressionRenderer()
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

// TODO: need a way to handle the lack of exceptions for this? use nil or a tuple?
//    func testRenderFailureWithWildcardInPatternLiteral() {
//        let string = self.renderer.render(
//            Dialekt.Pattern(
//                PatternLiteral("foo*")
//            )
//        )
//
//        XCTAssertNil(string, "The pattern literal \"foo*\" contains the wildcard string \"\(Token.WildcardString)\".")
//    }

// TODO: need a way to handle the lack of exceptions for this? use nil or a tuple?
//    func testPerformanceRenderFailureWithWildcardInPatternLiteral() {
//        let expression = Dialekt.Pattern(PatternLiteral("foo*"))
//        self.measureBlock() {
//            let string = self.renderer.render(expression)
//        }
//    }

    func renderTestVectors() -> [RenderTestVector] {
        return [
            RenderTestVector(
                name: "empty expression",
                expression: EmptyExpression(),
                expected: "NOT *"
            ),
            RenderTestVector(
                name: "tag",
                expression: Tag("foo"),
                expected: "foo"
            ),
            RenderTestVector(
                name: "escaped tag",
                expression: Tag("f\\o\"o"),
                expected: "\"f\\\\o\\\"o\""
            ),
            RenderTestVector(
                name: "escaped tag - logical and",
                expression: Tag("and"),
                expected: "\"and\""
            ),
            RenderTestVector(
                name: "escaped tag - logical or",
                expression: Tag("or"),
                expected: "\"or\""
            ),
            RenderTestVector(
                name: "escaped tag - logical not",
                expression: Tag("not"),
                expected: "\"not\""
            ),
            RenderTestVector(
                name: "tag with spaces",
                expression: Tag("foo bar"),
                expected: "\"foo bar\""
            ),
            RenderTestVector(
                name: "pattern",
                expression: Pattern(
                    PatternLiteral("foo"),
                    PatternWildcard()
                ),
                expected: "foo*"
            ),
            RenderTestVector(
                name: "escaped pattern",
                expression: Pattern(
                    PatternLiteral("foo\""),
                    PatternWildcard()
                ),
                expected: "\"foo\\\"*\""
            ),
            RenderTestVector(
                name: "logical and",
                expression: LogicalAnd(
                    Tag("a"),
                    Tag("b"),
                    Tag("c")
                ),
                expected: "(a AND b AND c)"
            ),
            RenderTestVector(
                name: "logical or",
                expression: LogicalOr(
                    Tag("a"),
                    Tag("b"),
                    Tag("c")
                ),
                expected: "(a OR b OR c)"
            ),
            RenderTestVector(
                name: "logical not",
                expression: LogicalNot(
                    Tag("a")
                ),
                expected: "NOT a"
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
