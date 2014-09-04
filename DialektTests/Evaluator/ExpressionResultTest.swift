import XCTest
import Dialekt

class ExpressionResultTest: XCTestCase {

    let expression = Tag("foo")
    let matchedTags = ["match1", "match2"]
    let unmatchedTags = ["unmatched1"]
    var result: ExpressionResult!

    override func setUp() {
        self.result = ExpressionResult(
            self.expression,
            true,
            self.matchedTags,
            self.unmatchedTags
        )
    }

    func testExpression() {
        XCTAssertEqual(
            self.expression,
            self.result.expression() as AbstractExpression
        )
    }

    func testPerformanceExpression() {
        self.measureBlock() {
            let x = self.result.expression()
        }
    }

    func testIsMatch() {
        XCTAssertTrue(self.result.isMatch())
    }

    func testPerformanceIsMatch() {
        self.measureBlock() {
            let match = self.result.isMatch()
        }
    }

    func testMatcedTags() {
        XCTAssertEqual(self.matchedTags.count, self.result.matchedTags().count)

        XCTAssertTrue(self.matchedTags == self.result.matchedTags())
    }

    func testPerformanceMatchedTags() {
        self.measureBlock() {
            let tags = self.result.matchedTags()
        }
    }

    func testUnmatcedTags() {
        XCTAssertEqual(self.unmatchedTags.count, self.result.unmatchedTags().count)

        XCTAssertTrue(self.unmatchedTags == self.result.unmatchedTags())
    }

    func testPerformanceUnmatchedTags() {
        self.measureBlock() {
            let tags = self.result.unmatchedTags()
        }
    }
}
