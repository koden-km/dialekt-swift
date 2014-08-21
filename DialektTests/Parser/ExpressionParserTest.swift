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

// TODO: this relies on the renderer to be correct. i'll need to test that first.
//    func testParse() {
//        for testVector in self.parseTestVectors() {
//            let result = self.parser.parse(testVector.expression)
//
//            XCTAssertEqual(
//                self.renderer.render(testVector.expected),
//                self.renderer.render(result),
//                testVector.name
//            )
//        }
//    }

    func testPerformanceParse() {
        self.measureBlock() {
            for testVector in self.parseTestVectors() {
                let result = self.parser.parse(testVector.expression)
            }
        }
    }

    // TODO: port more tests

    func parseTestVectors() -> [ParserTestVector] {
        return [
            ParserTestVector(
                name: "Empty expression",
                expression: "",
                expected: EmptyExpression()
            ),
            ParserTestVector(
                name: "Single tag",
                expression: "a",
                expected: Tag("a")
            ),
            ParserTestVector(
                name: "Tag pattern",
                expression: "a*",
                expected: Dialekt.Pattern(
                    PatternLiteral("a"),
                    PatternWildcard()
                )
            ),
            ParserTestVector(
                name: "Multiple tags",
                expression: "a b c",
                expected: LogicalAnd(
                    Tag("a"),
                    Tag("b"),
                    Tag("c")
                )
            ),
            ParserTestVector(
                name: "Multiple tags with nesting",
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
                name: "Multiple nested groups remain nested",
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
                name: "Logical and",
                expression: "a AND b",
                expected: LogicalAnd(
                    Tag("a"),
                    Tag("b")
                )
            ),
            ParserTestVector(
                name: "Logical and chained",
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
                name: "Logical or chained",
                expression: "a OR b OR c",
                expected: LogicalOr(
                    Tag("a"),
                    Tag("b"),
                    Tag("c")
                )
            ),
            ParserTestVector(
                name: "Logical not",
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
                name: "Logical operator implicit precedence 1",
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
                name: "Logical operator implicit precedence 2",
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
                name: "Logical operator explicit precedence 1",
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
                name: "Logical operator explicit precedence 2",
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
                name: "Logical not implicit precedence",
                expression: "NOT a AND b",
                expected: LogicalAnd(
                    LogicalNot(
                        Tag("a")
                    ),
                    Tag("b")
                )
            ),
            ParserTestVector(
                name: "Logical not explicit precedence",
                expression: "NOT (a AND b)",
                expected: LogicalNot(
                    LogicalAnd(
                        Tag("a"),
                        Tag("b")
                    )
                )
            ),
            ParserTestVector(
                name: "Complex nested",
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
}
