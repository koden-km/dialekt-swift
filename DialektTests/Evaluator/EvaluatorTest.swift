import XCTest
import Dialekt

class EvaluatorTest: XCTestCase {

    var evaluator: Evaluator!

    func testEvaluate() {
        self.evaluator = Evaluator()

        for testVector in self.evaluateTestVectors() {
            let result = self.evaluator.evaluate(
                testVector.expression,
                tags: testVector.tags
            )

            XCTAssertEqual(testVector.expected, result.isMatch(), testVector.name)
        }
    }

    func testPerformanceEvaluate() {
        self.evaluator = Evaluator()
        self.measureBlock() {
            for testVector in self.evaluateTestVectors() {
                let result = self.evaluator.evaluate(
                    testVector.expression,
                    tags: testVector.tags
                )
            }
        }
    }

    func testEvaluateTagCaseSensitive() {
        self.evaluator = Evaluator(caseSensitive: true)
        let expression = Tag("foo")

        XCTAssertTrue(
            self.evaluator.evaluate(
                expression,
                tags: ["foo"]
            ).isMatch()
        )

        XCTAssertFalse(
            self.evaluator.evaluate(
                expression,
                tags: ["FOO"]
            ).isMatch()
        )
    }

    func testPerformanceEvaluateTagCaseSensitive() {
        let expression = Tag("foo")
        let tagList = ["foo"]

        self.evaluator = Evaluator(caseSensitive: true)
        self.measureBlock() {
            let result = self.evaluator.evaluate(
                expression,
                tags: tagList
            )
        }
    }

    func testEvaluatePatternCaseSensitive() {
        self.evaluator = Evaluator(caseSensitive: true)
        let expression = Pattern(
            PatternLiteral("foo"),
            PatternWildcard()
        )
        
        XCTAssertTrue(
            self.evaluator.evaluate(
                expression,
                tags: ["foobar"]
            ).isMatch()
        )

        XCTAssertFalse(
            self.evaluator.evaluate(
                expression,
                tags: ["FOOBAR"]
            ).isMatch()
        )
    }

    func testPerformanceEvaluatePatternCaseSensitive() {
        let expression = Pattern(
            PatternLiteral("foo"),
            PatternWildcard()
        )

        let tagList = ["foobar"]

        self.evaluator = Evaluator(caseSensitive: true)
        self.measureBlock() {
            let result = self.evaluator.evaluate(
                expression,
                tags: tagList
            )
        }
    }

    func testEvaluateEmptyExpressionEmptyAsWildcard() {
        self.evaluator = Evaluator(caseSensitive: false, emptyIsWildcard: true)

        XCTAssertTrue(
            self.evaluator.evaluate(
                EmptyExpression(),
                tags: ["foo"]
            ).isMatch()
        )
    }

    func testPerformanceEvaluateEmptyExpressionEmptyAsWildcard() {
        let expression = EmptyExpression()
        let tagList = ["foo"]

        self.evaluator = Evaluator(caseSensitive: false, emptyIsWildcard: true)
        self.measureBlock() {
            let result = self.evaluator.evaluate(
                expression,
                tags: tagList
            )
        }
    }

    func testEvaluateLogicalAnd() {
        self.evaluator = Evaluator()

        let innerExpression1 = Tag("foo")
        let innerExpression2 = Tag("bar")
        let innerExpression3 = Tag("bar")

        let expression = LogicalAnd(
            innerExpression1,
            innerExpression2,
            innerExpression3
        )

        let result = self.evaluator.evaluate(
            expression,
            tags: ["foo", "bar", "spam"]
        )

        XCTAssertTrue(result.isMatch())

        var expressionResult: ExpressionResult

        expressionResult = result.resultOf(expression)
        XCTAssertNotNil(expressionResult)
        XCTAssertTrue(expressionResult.isMatch())
        XCTAssertTrue(["foo", "bar"] == expressionResult.matchedTags())
        XCTAssertTrue(["spam"] == expressionResult.unmatchedTags())

        expressionResult = result.resultOf(innerExpression1)
        XCTAssertNotNil(expressionResult)
        XCTAssertTrue(expressionResult.isMatch())
        XCTAssertTrue(["foo"] == expressionResult.matchedTags())
        XCTAssertTrue(["bar", "spam"] == expressionResult.unmatchedTags())

        expressionResult = result.resultOf(innerExpression2)
        XCTAssertNotNil(expressionResult)
        XCTAssertTrue(expressionResult.isMatch())
        XCTAssertTrue(["bar"] == expressionResult.matchedTags())
        XCTAssertTrue(["foo", "spam"] == expressionResult.unmatchedTags())

        expressionResult = result.resultOf(innerExpression3)
        XCTAssertNotNil(expressionResult)
        XCTAssertTrue(expressionResult.isMatch())
        XCTAssertTrue(["bar"] == expressionResult.matchedTags())
        XCTAssertTrue(["foo", "spam"] == expressionResult.unmatchedTags())
    }

    func testPerformanceEvaluateLogicalAnd() {
        let expression = LogicalAnd(
            Tag("foo"),
            Tag("bar"),
            Tag("bar")
        )

        let tagList = ["foo", "bar", "spam"]

        self.evaluator = Evaluator()
        self.measureBlock() {
            let result = self.evaluator.evaluate(
                expression,
                tags: tagList
            )
        }
    }

    func testEvaluateLogicalOr() {
        self.evaluator = Evaluator()

        let innerExpression1 = Tag("foo")
        let innerExpression2 = Tag("bar")
        let innerExpression3 = Tag("doom")

        let expression = LogicalOr(
            innerExpression1,
            innerExpression2,
            innerExpression3
        )

        let result = self.evaluator.evaluate(
            expression,
            tags: ["foo", "bar", "spam"]
        )

        XCTAssertTrue(result.isMatch())

        var expressionResult: ExpressionResult

        expressionResult = result.resultOf(expression)
        XCTAssertNotNil(expressionResult)
        XCTAssertTrue(expressionResult.isMatch())
        XCTAssertTrue(["foo", "bar"] == expressionResult.matchedTags())
        XCTAssertTrue(["spam"] == expressionResult.unmatchedTags())

        expressionResult = result.resultOf(innerExpression1)
        XCTAssertNotNil(expressionResult)
        XCTAssertTrue(expressionResult.isMatch())
        XCTAssertTrue(["foo"] == expressionResult.matchedTags())
        XCTAssertTrue(["bar", "spam"] == expressionResult.unmatchedTags())

        expressionResult = result.resultOf(innerExpression2)
        XCTAssertNotNil(expressionResult)
        XCTAssertTrue(expressionResult.isMatch())
        XCTAssertTrue(["bar"] == expressionResult.matchedTags())
        XCTAssertTrue(["foo", "spam"] == expressionResult.unmatchedTags())

        expressionResult = result.resultOf(innerExpression3)
        XCTAssertNotNil(expressionResult)
        XCTAssertFalse(expressionResult.isMatch())
        XCTAssertTrue([String]() == expressionResult.matchedTags())
        XCTAssertTrue(["foo", "bar", "spam"] == expressionResult.unmatchedTags())
    }

    func testPerformanceEvaluateLogicalOr() {
        let expression = LogicalOr(
            Tag("foo"),
            Tag("bar"),
            Tag("spam")
        )

        let tagList = ["foo", "bar", "spam"]

        self.evaluator = Evaluator()
        self.measureBlock() {
            let result = self.evaluator.evaluate(
                expression,
                tags: tagList
            )
        }
    }

    func testEvaluateLogicalNot() {
        self.evaluator = Evaluator()

        let innerExpression = Tag("foo")
        let expression = LogicalNot(innerExpression)

        let result = self.evaluator.evaluate(
            expression,
            tags: ["foo", "bar"]
        )

        XCTAssertFalse(result.isMatch())

        var expressionResult: ExpressionResult

        expressionResult = result.resultOf(expression)
        XCTAssertNotNil(expressionResult)
        XCTAssertFalse(expressionResult.isMatch())
        XCTAssertTrue(["bar"] == expressionResult.matchedTags())
        XCTAssertTrue(["foo"] == expressionResult.unmatchedTags())

        expressionResult = result.resultOf(innerExpression)
        XCTAssertNotNil(expressionResult)
        XCTAssertTrue(expressionResult.isMatch())
        XCTAssertTrue(["foo"] == expressionResult.matchedTags())
        XCTAssertTrue(["bar"] == expressionResult.unmatchedTags())
    }

    func testPerformanceEvaluateLogicalNot() {
        let expression = LogicalNot(Tag("foo"))

        let tagList = ["foo", "bar"]

        self.evaluator = Evaluator()
        self.measureBlock() {
            let result = self.evaluator.evaluate(
                expression,
                tags: tagList
            )
        }
    }

    func testEvaluateTag() {
        self.evaluator = Evaluator()

        let expression = Tag("foo")

        let result = self.evaluator.evaluate(
            expression,
            tags: ["foo", "bar"]
        )

        XCTAssertTrue(result.isMatch())

        var expressionResult: ExpressionResult

        expressionResult = result.resultOf(expression)
        XCTAssertNotNil(expressionResult)
        XCTAssertTrue(expressionResult.isMatch())
        XCTAssertTrue(["foo"] == expressionResult.matchedTags())
        XCTAssertTrue(["bar"] == expressionResult.unmatchedTags())
    }

    func testPerformanceEvaluateTag() {
        let expression = Tag("foo")

        let tagList = ["foo", "bar"]

        self.evaluator = Evaluator()
        self.measureBlock() {
            let result = self.evaluator.evaluate(
                expression,
                tags: tagList
            )
        }
    }

    func testEvaluatePattern() {
        self.evaluator = Evaluator()

        let expression = Dialekt.Pattern(
            PatternLiteral("foo"),
            PatternWildcard()
        )

        let result = self.evaluator.evaluate(
            expression,
            tags: ["foo1", "foo2", "bar"]
        )

        XCTAssertTrue(result.isMatch())

        var expressionResult: ExpressionResult

        expressionResult = result.resultOf(expression)
        XCTAssertNotNil(expressionResult)
        XCTAssertTrue(expressionResult.isMatch())
        XCTAssertTrue(["foo1", "foo2"] == expressionResult.matchedTags())
        XCTAssertTrue(["bar"] == expressionResult.unmatchedTags())
    }

    func testPerformanceEvaluatePattern() {
        let expression = Dialekt.Pattern(
            PatternLiteral("foo"),
            PatternWildcard()
        )

        let tagList = ["foo1", "foo2", "bar"]

        self.evaluator = Evaluator()
        self.measureBlock() {
            let result = self.evaluator.evaluate(
                expression,
                tags: tagList
            )
        }
    }

    func testEvaluateEmptyExpression() {
        self.evaluator = Evaluator()

        let expression = EmptyExpression()

        let result = self.evaluator.evaluate(
            expression,
            tags: ["foo", "bar"]
        )

        XCTAssertFalse(result.isMatch())

        var expressionResult: ExpressionResult

        expressionResult = result.resultOf(expression)
        XCTAssertNotNil(expressionResult)
        XCTAssertFalse(expressionResult.isMatch())
        XCTAssertTrue([String]() == expressionResult.matchedTags())
        XCTAssertTrue(["foo", "bar"] == expressionResult.unmatchedTags())
    }

    func testPerformanceEvaluateEmptyExpression() {
        let expression = EmptyExpression()

        let tagList = ["foo", "bar"]

        self.evaluator = Evaluator()
        self.measureBlock() {
            let result = self.evaluator.evaluate(
                expression,
                tags: tagList
            )
        }
    }

    func evaluateTestVectors() -> [EvaluateTestVector] {
        return [
            EvaluateTestVector(
                name: "Empty expression, Line: \(__LINE__)",
                expression: EmptyExpression(),
                tags: ["foo"],
                expected: false
            ),
            EvaluateTestVector(
                name: "Tag expression, Line: \(__LINE__)",
                expression: Tag("foo"),
                tags: ["foo"],
                expected: true
            ),
            EvaluateTestVector(
                name: "Tag expression, Line: \(__LINE__)",
                expression: Tag("foo"),
                tags: ["bar"],
                expected: false
            ),
            EvaluateTestVector(
                name: "Tag expression, Line: \(__LINE__)",
                expression: Tag("foo"),
                tags: ["foo", "bar"],
                expected: true
            ),
            EvaluateTestVector(
                name: "Pattern expression, Line: \(__LINE__)",
                expression: Pattern(
                    PatternLiteral("foo"),
                    PatternWildcard()
                ),
                tags: ["foobar"],
                expected: true
            ),
            EvaluateTestVector(
                name: "LogicalAnd expression, Line: \(__LINE__)",
                expression: LogicalAnd(
                    Tag("foo"),
                    Tag("bar")
                ),
                tags: ["foo"],
                expected: false
            ),
            EvaluateTestVector(
                name: "LogicalAnd expression, Line: \(__LINE__)",
                expression: LogicalAnd(
                    Tag("foo"),
                    Tag("bar")
                ),
                tags: ["bar"],
                expected: false
            ),
            EvaluateTestVector(
                name: "LogicalAnd expression, Line: \(__LINE__)",
                expression: LogicalAnd(
                    Tag("foo"),
                    Tag("bar")
                ),
                tags: ["foo", "bar"],
                expected: true
            ),
            EvaluateTestVector(
                name: "LogicalAnd expression, Line: \(__LINE__)",
                expression: LogicalAnd(
                    Tag("foo"),
                    Tag("bar")
                ),
                tags: ["foo", "bar", "spam"],
                expected: true
            ),
            EvaluateTestVector(
                name: "LogicalAnd expression, Line: \(__LINE__)",
                expression: LogicalAnd(
                    Tag("foo"),
                    Tag("bar")
                ),
                tags: ["foo", "spam"],
                expected: false
            ),
            EvaluateTestVector(
                name: "LogicalOr expression, Line: \(__LINE__)",
                expression: LogicalOr(
                    Tag("foo"),
                    Tag("bar")
                ),
                tags: ["foo"],
                expected: true
            ),
            EvaluateTestVector(
                name: "LogicalOr expression, Line: \(__LINE__)",
                expression: LogicalOr(
                    Tag("foo"),
                    Tag("bar")
                ),
                tags: ["bar"],
                expected: true
            ),
            EvaluateTestVector(
                name: "LogicalOr expression, Line: \(__LINE__)",
                expression: LogicalOr(
                    Tag("foo"),
                    Tag("bar")
                ),
                tags: ["foo", "spam"],
                expected: true
            ),
            EvaluateTestVector(
                name: "LogicalOr expression, Line: \(__LINE__)",
                expression: LogicalOr(
                    Tag("foo"),
                    Tag("bar")
                ),
                tags: ["spam"],
                expected: false
            ),
            EvaluateTestVector(
                name: "LogicalNot expression, Line: \(__LINE__)",
                expression: LogicalNot(
                    Tag("foo")
                ),
                tags: ["foo"],
                expected: false
            ),
            EvaluateTestVector(
                name: "LogicalNot expression, Line: \(__LINE__)",
                expression: LogicalNot(
                    Tag("foo")
                ),
                tags: ["foo", "bar"],
                expected: false
            ),
            EvaluateTestVector(
                name: "LogicalNot expression, Line: \(__LINE__)",
                expression: LogicalNot(
                    Tag("foo")
                ),
                tags: ["bar"],
                expected: true
            ),
            EvaluateTestVector(
                name: "LogicalNot expression, Line: \(__LINE__)",
                expression: LogicalNot(
                    Tag("foo")
                ),
                tags: ["bar", "spam"],
                expected: true
            ),
            EvaluateTestVector(
                name: "LogicalAnd expression, Line: \(__LINE__)",
                expression: LogicalAnd(
                    Tag("foo"),
                    LogicalNot(
                        Tag("bar")
                    )
                ),
                tags: ["foo"],
                expected: true
            ),
            EvaluateTestVector(
                name: "LogicalAnd expression, Line: \(__LINE__)",
                expression: LogicalAnd(
                    Tag("foo"),
                    LogicalNot(
                        Tag("bar")
                    )
                ),
                tags: ["foo", "spam"],
                expected: true
            ),
            EvaluateTestVector(
                name: "LogicalAnd expression, Line: \(__LINE__)",
                expression: LogicalAnd(
                    Tag("foo"),
                    LogicalNot(
                        Tag("bar")
                    )
                ),
                tags: ["foo", "bar", "spam"],
                expected: false
            ),
            EvaluateTestVector(
                name: "LogicalAnd expression, Line: \(__LINE__)",
                expression: LogicalAnd(
                    Tag("foo"),
                    LogicalNot(
                        Tag("bar")
                    )
                ),
                tags: ["spam"],
                expected: false
            ),
        ]
    }

    class EvaluateTestVector {
        var name: String
        var expression: ExpressionProtocol
        var tags: [String]
        var expected: Bool

        init(name: String, expression: ExpressionProtocol, tags: [String], expected: Bool) {
            self.name = name
            self.expression = expression
            self.tags = tags
            self.expected = expected
        }
    }
}
