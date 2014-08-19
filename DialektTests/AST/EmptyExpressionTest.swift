import XCTest
import Dialekt

class EmptyExpressionTest: XCTestCase {

    let expression = EmptyExpression()
    let mockVisitor = MockVisitorProtocol()
    let mockExpressionVisitor = MockExpressionVisitorProtocol()

    func testAcceptVisitorProtocol() {
        XCTAssertEqual(
            "<VisitorProtocol visit result: EmptyExpression>",
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
            "<ExpressionVisitorProtocol visit result: EmptyExpression>",
            self.expression.accept(self.mockExpressionVisitor)
        )
    }

    func testPerformanceAcceptExpressionVisitorProtocol() {
        self.measureBlock() {
            let result = self.expression.accept(self.mockExpressionVisitor)
        }
    }
}
