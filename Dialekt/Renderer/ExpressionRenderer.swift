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
    public func render(expression: ExpressionProtocol) -> String! {
        return expression.accept(self)
    }

    /// Visit a LogicalAnd node.
    public func visit(node: LogicalAnd) -> String! {
        return "(" + implodeNodes("AND", node.children()) + ")"
    }

    /// Visit a LogicalOr node.
    public func visit(node: LogicalOr) -> String! {
        return "(" + implodeNodes("OR", node.children()) + ")"
    }

    /// Visit a LogicalNot node.
    public func visit(node: LogicalNot) -> String! {
        return "NOT " + node.child().accept(self)
    }

    /// Visit a Tag node.
    public func visit(node: Tag) -> String! {
        return escapeString(node.name())
    }

    /// Visit a pattern node.
    public func visit(node: Pattern) -> String! {
        var string = ""
        for child in node.children() {
            if let result = child.accept(self) {
                string += result
            } else {
                // A nil result means an error occurred. eg. PatternLiteral contained the wildcard.
                return nil
            }
        }
        return escapeString(string)
    }

    /// Visit a PatternLiteral node.
    public func visit(node: PatternLiteral) -> String! {
        if node.string().rangeOfString(_wildcardString, options: NSStringCompareOptions.LiteralSearch) != nil {
            // TODO: Implement a Result<T>/Failable<T> return type.
            // throw Exception "The pattern literal \"" + node.string() + "\" contains the wildcard string \"" + _wildcardString + "\"."
            // fatalError("The pattern literal contains the wildcard string.")
            return nil
        }
        return node.string()
    }

    /// Visit a PatternWildcard node.
    public func visit(node: PatternWildcard) -> String! {
        return _wildcardString
    }

    /// Visit a EmptyExpression node.
    public func visit(node: EmptyExpression) -> String! {
        return "NOT " + _wildcardString
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
        let characters: [Character] = ["\\", "(", ")", "\""]
        for char in string {
            if contains(characters, char) {
                escapedString += "\\" + char
            } else {
                escapedString.append(char)
            }
        }

        if string != escapedString || escapedString.rangeOfCharacterFromSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()) != nil {
            return "\"" + escapedString + "\""
        }

        return escapedString
    }

    private let _wildcardString: String
}
