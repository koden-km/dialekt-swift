/// Protocol for pattern child visitors.
public protocol PatternChildVisitorProtocol {
    typealias PatternChildVisitorResultType

    /// Visit a PatternLiteral node.
    func visit(node: PatternLiteral) -> PatternChildVisitorResultType

    /// Visit a PatternWildcard node.
    func visit(node: PatternWildcard) -> PatternChildVisitorResultType
}
