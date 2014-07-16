/// Represents a literal (exact-match) portion of a pattern expression.
class PatternLiteral: PatternChildProtocol {
    init(_ string: String) {
        _string = string
    }

    /// Fetch the string to be matched.
    func string() -> String {
        return _string
    }

    /// Pass this node to the appropriate method on the given visitor.
    func accept<T: VisitorProtocol>(visitor: T) -> T.VisitorResultType {
        return visitor.visitPatternLiteral(self) as T.VisitorResultType
    }

    /// Pass this node to the appropriate method on the given visitor.
    func accept<T: PatternChildVisitorProtocol>(visitor: T) -> T.PatternChildVisitorResultType {
        return visitor.visitPatternLiteral(self)
    }

    let _string: String
}
