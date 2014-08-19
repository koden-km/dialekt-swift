public enum TokenType: Int, Printable {
    case LogicalAnd
    case LogicalOr
    case LogicalNot
    case Text
    case OpenBracket
    case CloseBracket

    public var description: String {
        switch self {
        case .LogicalAnd:
            return "AND operator"
        case .LogicalOr:
            return "OR operator"
        case .LogicalNot:
            return "NOT operator"
        case .OpenBracket:
            return "open bracket"
        case .CloseBracket:
            return "close bracket"
        case .Text:
            return "tag"
        }
    }
}

public class Token {
    public class var WildcardString: String {
        return "*"
    }

    public init(
        _ type: TokenType,
        _ value: String,
        _ startOffset: Int,
        _ endOffset: Int,
        _ lineNumber: Int,
        _ columnNumber: Int
    ) {
        self.tokenType = type
        self.value = value
        self.startOffset = startOffset
        self.endOffset = endOffset
        self.lineNumber = lineNumber
        self.columnNumber = columnNumber
    }
    
    public var tokenType: TokenType
    public var value: String
    public var startOffset: Int
    public var endOffset: Int
    public var lineNumber: Int
    public var columnNumber: Int
}

// MARK: Equatable

extension Token: Equatable { }

public func ==(lhs: Token, rhs: Token) -> Bool {
    return lhs.tokenType == rhs.tokenType
        && lhs.value == rhs.value
        && lhs.startOffset == rhs.startOffset
        && lhs.endOffset == rhs.endOffset
        && lhs.lineNumber == rhs.lineNumber
        && lhs.columnNumber == rhs.columnNumber
}
