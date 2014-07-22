/// Represents the actual wildcard portion of a pattern expression.
public class PatternWildcard: PatternChildProtocol {
    /// Pass this node to the appropriate method on the given visitor.
    public func accept<T: VisitorProtocol>(visitor: T) -> T.VisitorResultType {
        return visitor.visit(self) as T.VisitorResultType
    }

    /// Pass this node to the appropriate method on the given visitor.
    public func accept<T: PatternChildVisitorProtocol>(visitor: T) -> T.PatternChildVisitorResultType {
        return visitor.visit(self)
    }
}
