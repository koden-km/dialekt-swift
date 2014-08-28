import Foundation

/// Render an AST expression to a string representing the tree structure.
public class TreeRenderer: RendererProtocol, VisitorProtocol {
    public init(endOfLine: String) {
        _endOfLine = endOfLine
    }

    public convenience init() {
        self.init(endOfLine: "\n")
    }

    /// Get the end-of-line string.
    public func endOfLine() -> String {
        return _endOfLine
    }

    /// Render an expression to a string.
    public func render(expression: ExpressionProtocol) -> String! {
        return expression.accept(self)
    }

    /// Visit a LogicalAnd node.
    public func visit(node: LogicalAnd) -> String {
        return "AND" + _endOfLine + renderChildren(
            node.children().map {
                $0.accept(self)
            }
        )
    }

    /// Visit a LogicalOr node.
    public func visit(node: LogicalOr) -> String {
        return "OR" + _endOfLine + renderChildren(
            node.children().map {
                $0.accept(self)
            }
        )
    }

    /// Visit a LogicalNot node.
    public func visit(node: LogicalNot) -> String {
        return "NOT" + _endOfLine + indent("- " + node.child().accept(self))
    }

    /// Visit a Tag node.
    public func visit(node: Tag) -> String {
        return "TAG " + encodeString(node.name())
    }

    /// Visit a Pattern node.
    public func visit(node: Pattern) -> String {
        return "PATTERN" + _endOfLine + renderChildren(
            node.children().map {
                $0.accept(self)
            }
        )
    }

    /// Visit a PatternLiteral node.
    public func visit(node: PatternLiteral) -> String {
        return "LITERAL " + encodeString(node.string())
    }

    /// Visit a PatternWildcard node.
    public func visit(node: PatternWildcard) -> String {
        return "WILDCARD"
    }

    /// Visit a EmptyExpression node.
    public func visit(node: EmptyExpression) -> String {
        return "EMPTY"
    }

    private func renderChildren(children: [String]) -> String {
        var output = ""

        for str in children {
            output += indent("- " + str) + _endOfLine
        }

        return output.substringToIndex(
            advance(output.endIndex, -countElements(_endOfLine))
        )
    }

    private func indent(string: String) -> String {
        return "  " + string.stringByReplacingOccurrencesOfString(
            _endOfLine,
            withString: " " + _endOfLine,
            options: NSStringCompareOptions.LiteralSearch
        )
    }

    private func encodeString(string: String) -> String {
        // Swift/Objective-C json encoding keeps throwing exceptions and requires the string being inside an Array?
        // I found this solution on Stack Overflow.
        // See: http://stackoverflow.com/questions/3020094/how-should-i-escape-strings-in-json
        var escapedString = ""
        escapedString += "\""
        for char in string {
            if char == "\\" || char == "\"" {
                escapedString += "\\" + char
            } else if char == "/" {
                escapedString += "\\" + char
            } else if char == "\t" {
                escapedString += "\\t"
            } else if char == "\n" {
                escapedString += "\\n"
            } else if char == "\r" {
                escapedString += "\\r"
            // Swift does not allow this?
            // } else if char == "\b" {
            //    escapedString += "\\b"
            // Swift does not allow this?
            // } else if char == "\f" {
            //    escapedString += "\\f"
            } else {
                escapedString.append(char)
            }
        }
        escapedString += "\""
        return escapedString
    }

    private let _endOfLine: String
}
