/// Represents a literal (exact-match) portion of a pattern expression.
class PatternLiteral: PatternChildProtocol {
    let _string: String
    
    init(string: String) {
        _string = string
    }
    
    /// Fetch the string to be matched.
    func string() -> String {
        return _string
    }

    /// Pass this node to the appropriate method on the given visitor.
//    func accept<T: VisitorProtocol>(visitor: T) -> Any {
//    func accept<T: VisitorProtocol>(visitor: T) -> T.VisitResultType {
//    func accept<T: VisitorProtocol>(visitor: T) -> T.VisitResultTypePattern {
//    func accept<T: VisitorProtocol>(visitor: T) -> T.VisitResultTypeFoo {
//    func accept<T: VisitorProtocol>(visitor: T) -> T.VisitResultTypePattern {
//        return visitor.visitPatternLiteral(self)
//    }
    
    /// Pass this node to the appropriate method on the given visitor.
//    func accept<T: PatternChildVisitorProtocol>(visitor: T) -> String {
//    func accept<T: PatternChildVisitorProtocol>(visitor: T) -> T.VisitResultType {
    func accept<T: PatternChildVisitorProtocol>(visitor: T) -> T.VisitResultTypePattern {
        return visitor.visitPatternLiteral(self)
    }
}
