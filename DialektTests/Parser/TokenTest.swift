import XCTest
import Dialekt

class TokenTest: XCTestCase {

    func testConstructor() {
        let token = Token(
            TokenType.Text,
            "foo",
            1,
            2,
            3,
            4
        )

        XCTAssertEqual(TokenType.Text, token.tokenType)
        XCTAssertEqual("foo", token.value)
        XCTAssertEqual(1, token.startOffset)
        XCTAssertEqual(2, token.endOffset)
        XCTAssertEqual(3, token.lineNumber)
        XCTAssertEqual(4, token.columnNumber)
    }

    func testTypeDescription() {
        for testVector in self.descriptionTestVectors() {
            XCTAssertEqual(testVector.description, testVector.tokenType.description)
        }
    }

    func descriptionTestVectors() -> [DescriptionTestVector] {
        return [
            DescriptionTestVector(
                tokenType: .LogicalAnd,
                description: "AND operator"
            ),
            DescriptionTestVector(
                tokenType: .LogicalOr,
                description: "OR operator"
            ),
            DescriptionTestVector(
                tokenType: .LogicalNot,
                description: "NOT operator"
            ),
            DescriptionTestVector(
                tokenType: .Text,
                description: "tag"
            ),
            DescriptionTestVector(
                tokenType: .OpenBracket,
                description: "open bracket"
            ),
            DescriptionTestVector(
                tokenType: .CloseBracket,
                description: "close bracket"
            )
        ]
    }

    class DescriptionTestVector {
        var tokenType: TokenType
        var description: String

        init(tokenType: TokenType, description: String) {
            self.tokenType = tokenType
            self.description = description
        }
    }
}
