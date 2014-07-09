/// Represents the actual wildcard portion of a pattern expression.
class PatternWildcard: PatternChildProtocol {
    /// Pass this node to the appropriate method on the given visitor.
//    func accept<T: VisitorProtocol>(visitor: T) -> Any {
    func accept<T: VisitorProtocol>(visitor: T) -> T.VisitResultType {
        return visitor.visitPatternWildcard(self)
    }

    /// Pass this node to the appropriate method on the given visitor.
//    func accept<T: PatternChildVisitorProtocol>(visitor: T) -> String {
    func accept<T: PatternChildVisitorProtocol>(visitor: T) -> T.VisitResultType {
        return visitor.visitPatternWildcard(self)
    }
}
