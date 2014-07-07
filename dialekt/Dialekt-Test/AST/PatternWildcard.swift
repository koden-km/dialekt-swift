// Represents the actual wildcard portion of a pattern expression.
class PatternWildcard: PatternChildProtocol {
    // Pass this node to the appropriate method on the given visitor.
    func accept(visitor: VisitorProtocol) -> Any {
        return visitor.visitPatternWildcard(self)
    }

    // Pass this node to the appropriate method on the given visitor.
    func accept(visitor: PatternChildVisitorProtocol) -> String {
        return visitor.visitPatternWildcard(self)
    }
}
