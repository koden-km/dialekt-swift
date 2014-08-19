import XCTest
import Dialekt

class EvaluationResultTest: XCTestCase {

    let expression = Tag("foo")
    var expressionResult: ExpressionResult!
    var evaluationResult: EvaluationResult!

    override func setUp() {
        self.expressionResult = ExpressionResult(
            self.expression,
            true,
            [],
            []
        )

        self.evaluationResult = EvaluationResult(
            true,
            [self.expressionResult]
        )
    }

    func testIsMatch() {
        XCTAssertTrue(self.evaluationResult.isMatch())
    }

    func testPerformanceIsMatch() {
        self.measureBlock() {
            let match = self.evaluationResult.isMatch()
        }
    }

    func testResultOf() {
        let result = self.evaluationResult.resultOf(
            self.expression
        ).expression()

        XCTAssertEqual(self.expression, result as AbstractExpression)

        XCTAssertTrue(result is Tag)
        if let tagExpression = result as? Tag {
            XCTAssertTrue(tagExpression === self.expression)
            XCTAssertEqual(self.expression.name(), tagExpression.name())
        } else {
            XCTAssertTrue(false, "Expected Tag expression type.")
        }
    }

    func testPerformanceResultOf() {
        self.measureBlock() {
            let result = self.evaluationResult.resultOf(self.expression)
        }
    }

    func testResultOfWithUnknownExpression() {
        XCTAssertNil(self.evaluationResult.resultOf(EmptyExpression()))
    }

    func testPerformanceResultOfWithUnknownExpression() {
        self.measureBlock() {
            let result = self.evaluationResult.resultOf(EmptyExpression())
        }
    }
}
