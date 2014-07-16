import Foundation

class ExpressionRenderer: RendererProtocol, VisitorProtocol {
    init(wildcardString: String) {
        _wildcardString = wildcardString
    }

    convenience init() {
        self.init(wildcardString: Token.WildcardString)
    }

    /// Render an expression to a string.
    func render(expression: ExpressionProtocol) -> String {
            return expression.accept(self)
    }

    /// Visit a LogicalAnd node.
    func visitLogicalAnd(node: LogicalAnd) -> String {
        return _implodeNodes("AND", node.children())
    }

    /// Visit a LogicalOr node.
    func visitLogicalOr(node: LogicalOr) -> String {
        return _implodeNodes("OR", node.children())
    }

    /// Visit a LogicalNot node.
    func visitLogicalNot(node: LogicalNot) -> String {
        return "NOT " + node.child().accept(self)
    }

    /// Visit a Tag node.
    func visitTag(node: Tag) -> String {
        return _escapeString(node.name())
    }

    /// Visit a pattern node.
    func visitPattern(node: Pattern) -> String {
        return "".join(
            node.children().map() {
                $0.accept(self)
            }
        )
    }

    /// Visit a EmptyExpression node.
    func visitEmptyExpression(node: EmptyExpression) -> String {
        return "NOT " + _wildcardString
    }

    /// Visit a PatternLiteral node.
    func visitPatternLiteral(node: PatternLiteral) -> String {
        // TODO: fail if node.string() contains wildcard
        return _escapeString(node.string())
    }

    /// Visit a PatternWildcard node.
    func visitPatternWildcard(node: PatternWildcard) -> String {
        return _wildcardString
    }

    func _implodeNodes(separator: String, _ nodes: [ExpressionProtocol]) -> String {
        return (" " + separator + " ").join(
            nodes.map() {
                $0.accept(self)
            }
        )
    }

    func _escapeString(string: String) -> String {
        let stringLower = string.lowercaseString
        if "and" == stringLower || "or" == stringLower || "not" == stringLower {
            return "\"" + string + "\""
        }

        // TODO: replace other characters

        return string
    }

    let _wildcardString: String
}
