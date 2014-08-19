import XCTest
import Dialekt

class AbstractExpressionTest: XCTestCase {

    var node = AbstractExpression()

    func testDefaults() {
        XCTAssertNil(self.node.firstToken())
        XCTAssertNil(self.node.lastToken())
    }

    func testPerformanceDefaults() {
        self.measureBlock() {
            self.node.firstToken()
            self.node.lastToken()
        }
    }

    func testSetTokens() {
        let firstToken = Token(TokenType.Text, "first", 0, 1, 2, 3)
        let lastToken = Token(TokenType.Text, "last", 4, 5, 6, 7)

        self.node.setTokens(firstToken, lastToken)

        XCTAssertEqual(firstToken, self.node.firstToken()!)
        XCTAssertEqual(lastToken, self.node.lastToken()!)
    }

    func testPerformanceSetTokens() {
        let firstToken = Token(TokenType.Text, "first", 0, 1, 2, 3)
        let lastToken = Token(TokenType.Text, "last", 4, 5, 6, 7)

        self.node.setTokens(firstToken, lastToken)

        self.measureBlock() {
            self.node.setTokens(firstToken, lastToken)
        }
    }
}
