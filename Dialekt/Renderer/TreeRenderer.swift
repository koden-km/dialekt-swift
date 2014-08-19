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
    public func render(expression: ExpressionProtocol) -> String {
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
        return "LITTERAL" + encodeString(node.string())
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
        return " " + string.stringByReplacingOccurrencesOfString(
            _endOfLine,
            withString: " " + _endOfLine,
            options: NSStringCompareOptions.LiteralSearch
        )
    }

    private func encodeString(string: String) -> String {
        let jsonObj: AnyObject = string
        var e: NSError?
        let jsonData = NSJSONSerialization.dataWithJSONObject(
            jsonObj,
            options: NSJSONWritingOptions(0),
            error: &e
        )
        if e == nil {
            return ""
        } else {
            return NSString(data: jsonData!, encoding: NSUTF8StringEncoding)
        }
    }

    private let _endOfLine: String
}
