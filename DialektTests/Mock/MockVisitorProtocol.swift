import Dialekt

class MockVisitorProtocol: VisitorProtocol {
    func visit(node: LogicalAnd) -> String {
        return "<VisitorProtocol visit result: LogicalAnd>"
    }

    func visit(node: LogicalOr) -> String {
        return "<VisitorProtocol visit result: LogicalOr>"
    }

    func visit(node: LogicalNot) -> String {
        return "<VisitorProtocol visit result: LogicalNot>"
    }

    func visit(node: Tag) -> String {
        return "<VisitorProtocol visit result: Tag>"
    }

    func visit(node: Dialekt.Pattern) -> String {
        return "<VisitorProtocol visit result: Pattern>"
    }

    func visit(node: EmptyExpression) -> String {
        return "<VisitorProtocol visit result: EmptyExpression>"
    }

    func visit(node: PatternLiteral) -> String {
        return "<VisitorProtocol visit result: PatternLiteral>"
    }

    func visit(node: PatternWildcard) -> String {
        return "<VisitorProtocol visit result: PatternWildcard>"
    }
}
