import XCTest
import Dialekt

class LogicalNotTest: XCTestCase {

    let expression = LogicalNot(Tag("foo"))
    let mockVisitor = MockVisitorProtocol()
    let mockExpressionVisitor = MockExpressionVisitorProtocol()

    func testChild() {
        if let tag = self.expression.child() as? Tag {
            XCTAssertEqual("foo", tag.name())
        } else {
            XCTAssertTrue(false, "Expected child to be a Tag")
        }
    }

    func testPerformanceChild() {
        self.measureBlock() {
            let child = self.expression.child()
        }
    }

    func testAcceptVisitorProtocol() {
        XCTAssertEqual(
            "<VisitorProtocol visit result: LogicalNot>",
            self.expression.accept(self.mockVisitor)
        )
    }

    func testPerformanceAcceptVisitorProtocol() {
        self.measureBlock() {
            let result = self.expression.accept(self.mockVisitor)
        }
    }

    func testAcceptExpressionVisitorProtocol() {
        XCTAssertEqual(
            "<ExpressionVisitorProtocol visit result: LogicalNot>",
            self.expression.accept(self.mockExpressionVisitor)
        )
    }

    func testPerformanceAcceptExpressionVisitorProtocol() {
        self.measureBlock() {
            let result = self.expression.accept(self.mockExpressionVisitor)
        }
    }
}
