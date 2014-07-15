/// Protocol for node visitors.
protocol VisitorProtocol: ExpressionVisitorProtocol, PatternChildVisitorProtocol {
    typealias VisitResultType
//    typealias ExpressionVisitorProtocol.VisitResultType = VisitResultType
//    typealias PatternChildVisitorProtocol.VisitResultType = VisitResultType
}
