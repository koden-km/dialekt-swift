import XCTest
import Dialekt

class LogicalAndTest: XCTestCase {

    let expression = LogicalAnd()
    let mockVisitor = MockVisitorProtocol()
    let mockExpressionVisitor = MockExpressionVisitorProtocol()

    func testAcceptVisitorProtocol() {
        XCTAssertEqual(
            "<VisitorProtocol visit result: LogicalAnd>",
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
            "<ExpressionVisitorProtocol visit result: LogicalAnd>",
            self.expression.accept(self.mockExpressionVisitor)
        )
    }

    func testPerformanceAcceptExpressionVisitorProtocol() {
        self.measureBlock() {
            let result = self.expression.accept(self.mockExpressionVisitor)
        }
    }
}
