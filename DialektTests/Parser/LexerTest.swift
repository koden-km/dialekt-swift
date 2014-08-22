import XCTest
import Dialekt

class LexerTest: XCTestCase {

    var lexer: Lexer!

    override func setUp() {
        super.setUp()

        self.lexer = Lexer()
    }

    func testLex() {
        for testVector in self.lexTestVectors() {
            let result = self.lexer.lex(testVector.expression)

            XCTAssertEqual(testVector.expected, result, testVector.name)
        }
    }

    func testPerformanceLex() {
        self.measureBlock() {
            for testVector in self.lexTestVectors() {
                let result = self.lexer.lex(testVector.expression)
            }
        }
    }

// TODO: port more test vectors
    func lexTestVectors() -> [LexTestVector] {
        return [
            LexTestVector(
                name: "empty expression",
                expression: "",
                expected: [Token]()
            ),
        ]
    }

    class LexTestVector {
        var name: String
        var expression: String
        var expected: [Token]

        init(name: String, expression: String, expected: [Token]) {
            self.name = name
            self.expression = expression
            self.expected = expected
        }
    }
}
