import XCTest
import Dialekt

class ExpressionParserTest: XCTestCase {

    var renderer: ExpressionRenderer!
    var parser: ExpressionParser!

    override func setUp() {
        super.setUp()

        self.renderer = ExpressionRenderer()
        self.parser = ExpressionParser()
    }

    func testParse() {
        for testVector in self.parseTestVectors() {
            let result = self.parser.parse(testVector.expression)

            XCTAssertEqual(
                self.renderer.render(testVector.expected),
                self.renderer.render(result),
                testVector.name
            )
        }
    }

    func testPerformanceParse() {
        self.measureBlock() {
            for testVector in self.parseTestVectors() {
                let result = self.parser.parse(testVector.expression)
            }
        }
    }

    // TODO: port more tests

// TODO: port more parse test vectors
    func parseTestVectors() -> [ParserTestVector] {
        return [
            ParserTestVector(
                name: "Empty expression",
                expression: "",
                expected: EmptyExpression()
            ),
        ]
    }

    class ParserTestVector {
        var name: String
        var expression: String
        var expected: ExpressionProtocol

        init(name: String, expression: String, expected: ExpressionProtocol) {
            self.name = name
            self.expression = expression
            self.expected = expected
        }
    }
}
