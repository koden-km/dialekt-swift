import XCTest
import Dialekt

class PatternWildcardTest: XCTestCase {

    let node = PatternWildcard()
    let mockVisitor = MockVisitorProtocol()
    let mockPatternChildVisitor = MockPatternChildVisitorProtocol()

    func testAcceptVisitorProtocol() {
        XCTAssertEqual(
            "<VisitorProtocol visit result: PatternWildcard>",
            self.node.accept(self.mockVisitor)
        )
    }

    func testPerformanceAcceptVisitorProtocol() {
        self.measureBlock() {
            let result = self.node.accept(self.mockVisitor)
        }
    }

    func testAcceptPatternChildVisitorProtocol() {
        XCTAssertEqual(
            "<PatternChildVisitorProtocol visit result: PatternWildcard>",
            self.node.accept(self.mockPatternChildVisitor)
        )
    }

    func testPerformanceAcceptPatternChildVisitorProtocol() {
        self.measureBlock() {
            let result = self.node.accept(self.mockPatternChildVisitor)
        }
    }
}
