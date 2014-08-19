import Dialekt

class MockPatternChildVisitorProtocol: PatternChildVisitorProtocol {
    func visit(node: PatternLiteral) -> String {
        return "<PatternChildVisitorProtocol visit result: PatternLiteral>"
    }

    func visit(node: PatternWildcard) -> String {
        return "<PatternChildVisitorProtocol visit result: PatternWildcard>"
    }
}
