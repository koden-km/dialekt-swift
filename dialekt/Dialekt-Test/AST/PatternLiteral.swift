/// Represents a literal (exact-match) portion of a pattern expression.
class PatternLiteral: PatternChildProtocol {

    init(_ string: String) {
        _string = string
    }

    /// Fetch the string to be matched.
    func string() -> String {
        return _string
    }

    func accept<T: VisitorProtocol>(visitor: T) -> T.VisitorResultType {
        return visitor.visitPatternLiteral(self) as T.VisitorResultType
    }

    func accept<T: PatternChildVisitorProtocol>(visitor: T) -> T.PatternChildVisitorResultType {
        return visitor.visitPatternLiteral(self)
    }
    
    let _string: String
}
