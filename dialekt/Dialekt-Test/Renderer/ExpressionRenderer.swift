import Foundation

public class ExpressionRenderer: RendererProtocol, VisitorProtocol {
    public init(wildcardString: String) {
        _wildcardString = wildcardString
    }

    public convenience init() {
        self.init(wildcardString: Token.WildcardString)
    }

    /// Render an expression to a string.
    public func render(expression: ExpressionProtocol) -> String {
            return expression.accept(self)
    }

    /// Visit a LogicalAnd node.
    public func visit(node: LogicalAnd) -> String {
        return _implodeNodes("AND", node.children())
    }

    /// Visit a LogicalOr node.
    public func visit(node: LogicalOr) -> String {
        return _implodeNodes("OR", node.children())
    }

    /// Visit a LogicalNot node.
    public func visit(node: LogicalNot) -> String {
        return "NOT " + node.child().accept(self)
    }

    /// Visit a Tag node.
    public func visit(node: Tag) -> String {
        return _escapeString(node.name())
    }

    /// Visit a pattern node.
    public func visit(node: Pattern) -> String {
        return "".join(
            node.children().map {
                $0.accept(self)
            }
        )
    }

    /// Visit a EmptyExpression node.
    public func visit(node: EmptyExpression) -> String {
        return "NOT " + _wildcardString
    }

    /// Visit a PatternLiteral node.
    public func visit(node: PatternLiteral) -> String {
        // TODO: fail if node.string() contains wildcard
        return _escapeString(node.string())
    }

    /// Visit a PatternWildcard node.
    public func visit(node: PatternWildcard) -> String {
        return _wildcardString
    }

    private func _implodeNodes(separator: String, _ nodes: [ExpressionProtocol]) -> String {
        return (" " + separator + " ").join(
            nodes.map {
                $0.accept(self)
            }
        )
    }

    private func _escapeString(string: String) -> String {
        let stringLower = string.lowercaseString
        if "and" == stringLower || "or" == stringLower || "not" == stringLower {
            return "\"" + string + "\""
        }

        // TODO: replace other characters

        return string
    }

    private let _wildcardString: String
}
