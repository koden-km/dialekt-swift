/// Represents a literal (exact-match) portion of a pattern expression.
public class PatternLiteral: PatternChildProtocol {
    public init(_ string: String) {
        _string = string
    }

    /// Fetch the string to be matched.
    public func string() -> String {
        return _string
    }

    /// Pass this node to the appropriate method on the given visitor.
    public func accept<T: VisitorProtocol>(visitor: T) -> T.VisitorResultType {
        return visitor.visit(self) as T.VisitorResultType
    }

    /// Pass this node to the appropriate method on the given visitor.
    public func accept<T: PatternChildVisitorProtocol>(visitor: T) -> T.PatternChildVisitorResultType {
        return visitor.visit(self)
    }

    private let _string: String
}
