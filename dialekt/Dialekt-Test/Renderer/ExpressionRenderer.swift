import Foundation

/// Renders an AST expression to an expression string.
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
        return implodeNodes("AND", node.children())
    }

    /// Visit a LogicalOr node.
    public func visit(node: LogicalOr) -> String {
        return implodeNodes("OR", node.children())
    }

    /// Visit a LogicalNot node.
    public func visit(node: LogicalNot) -> String {
        return "NOT " + node.child().accept(self)
    }

    /// Visit a Tag node.
    public func visit(node: Tag) -> String {
        return escapeString(node.name())
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
        // TODO: throw "The pattern literal \"" + node.string() + "\" contains the wildcard string \"" + _wildcardString + "\"."
        if node.string().rangeOfString(_wildcardString, options: NSStringCompareOptions.LiteralSearch) == nil {
            fatalError("The pattern literal contains the wildcard string.")
        }
        return escapeString(node.string())
    }

    /// Visit a PatternWildcard node.
    public func visit(node: PatternWildcard) -> String {
        return _wildcardString
    }

    private func implodeNodes(separator: String, _ nodes: [ExpressionProtocol]) -> String {
        return (" " + separator + " ").join(
            nodes.map {
                $0.accept(self)
            }
        )
    }

    private func escapeString(string: String) -> String {
        let stringLower = string.lowercaseString
        if "and" == stringLower || "or" == stringLower || "not" == stringLower {
            return "\"" + string + "\""
        }

        var escapedString = ""
        let characters = ["\\", "(", ")", "\""]
        for c in string {
            if !contains(string, c) {
                escapedString += c
            }
        }

        if string.rangeOfString(".*[\\s\\\\].*", options: NSStringCompareOptions.RegularExpressionSearch) != nil {
            return "\"" + escapedString + "\""
        }

        return escapedString
    }

    private let _wildcardString: String
}
