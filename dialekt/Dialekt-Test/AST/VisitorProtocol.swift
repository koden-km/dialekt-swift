/// Protocol for node visitors.
public protocol VisitorProtocol: ExpressionVisitorProtocol, PatternChildVisitorProtocol {
    typealias VisitorResultType

    /// Visit a LogicalAnd node.
    func visit(node: LogicalAnd) -> VisitorResultType

    /// Visit a LogicalOr node.
    func visit(node: LogicalOr) -> VisitorResultType

    /// Visit a LogicalNot node.
    func visit(node: LogicalNot) -> VisitorResultType

    /// Visit a Tag node.
    func visit(node: Tag) -> VisitorResultType

    /// Visit a pattern node.
    func visit(node: Pattern) -> VisitorResultType

    /// Visit a EmptyExpression node.
    func visit(node: EmptyExpression) -> VisitorResultType

    /// Visit a PatternLiteral node.
    func visit(node: PatternLiteral) -> VisitorResultType

    /// Visit a PatternWildcard node.
    func visit(node: PatternWildcard) -> VisitorResultType
}
