/// Represents the actual wildcard portion of a pattern expression.
class PatternWildcard: PatternChildProtocol {

    func accept<T: VisitorProtocol>(visitor: T) -> T.VisitorResultType {
        return visitor.visitPatternWildcard(self) as T.VisitorResultType
    }

    func accept<T: PatternChildVisitorProtocol>(visitor: T) -> T.PatternChildVisitorResultType {
        return visitor.visitPatternWildcard(self)
    }
}
