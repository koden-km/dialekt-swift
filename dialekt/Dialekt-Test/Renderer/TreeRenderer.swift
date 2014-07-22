/*
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
        return "AND" + _endOfLine + renderChildren(node.children())
    }

    /// Visit a LogicalOr node.
    public func visit(node: LogicalOr) -> String {
        return "OR" + _endOfLine + renderChildren(node.children())
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
        return "PATTERN" + _endOfLine + renderChildren(node.children())
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

    private func renderChildren<T: NodeProtocol>(children: [T]) -> String {
        var output = ""

        for n in children {
            output += indent("- " + n.accept(self)) + _endOfLine
        }

// TODO
//        return output.substring(
//            0,
//            output.length() - this.endOfLine.length()
//        )

        return "TODO"
    }

    private func indent(string: String) -> String {
//        return "  " + string.replace(this.endOfLine, "  " + this.endOfLine)
        return "TODO"
    }

    private func encodeString(string: String) -> String {
//        return JSONObject.quote(string)
        return "TODO"
    }

    private let _endOfLine: String
}
*/
