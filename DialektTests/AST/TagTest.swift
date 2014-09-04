import XCTest
import Dialekt

class TagTest: XCTestCase {

    let expression = Tag("foo")
    let mockVisitor = MockVisitorProtocol()
    let mockExpressionVisitor = MockExpressionVisitorProtocol()

    func testName() {
        XCTAssertEqual("foo", self.expression.name())
    }

    func testPerformanceString() {
        self.measureBlock() {
            let name = self.expression.name()
        }
    }

    func testAcceptVisitorProtocol() {
        XCTAssertEqual(
            "<VisitorProtocol visit result: Tag>",
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
            "<ExpressionVisitorProtocol visit result: Tag>",
            self.expression.accept(self.mockExpressionVisitor)
        )
    }

    func testPerformanceAcceptExpressionVisitorProtocol() {
        self.measureBlock() {
            let result = self.expression.accept(self.mockExpressionVisitor)
        }
    }
}
