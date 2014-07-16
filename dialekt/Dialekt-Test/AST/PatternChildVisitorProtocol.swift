protocol PatternChildVisitorProtocol {
    typealias PatternChildVisitorResultType;

    func visitPatternLiteral(node: PatternLiteral) -> PatternChildVisitorResultType
    func visitPatternWildcard(node: PatternWildcard) -> PatternChildVisitorResultType
}
