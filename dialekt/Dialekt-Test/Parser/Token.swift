//// Note: class (static) variables not yet supported in Swift apparently.
//let Token_WILDCARD_CHARACTER = "*"
//
//// not sure if i should do this outside for idomatic Swift
////enum TokenType: Int {
////    case
////    LOGICAL_AND   = 1,
////    LOGICAL_OR    = 2,
////    LOGICAL_NOT   = 3,
////    STRING        = 4,
////    OPEN_BRACKET  = 6,
////    CLOSE_BRACKET = 7
////}
//
//// NOTE: should this be a struct?
class Token { // : Equatable {
////    class let WILDCARD_CHARACTER = "*"
//
//// TODO: is the word Type already used? it seems to allow it...
//    enum Type {
////    enum Type: Int {
////    enum `Type`: Int {
////    enum TokenType: Int {
//        case LOGICAL_AND
//        case LOGICAL_OR
//        case LOGICAL_NOT
//        case STRING
//        case OPEN_BRACKET
//        case CLOSE_BRACKET
//
//        var description: String {
//            switch self {
//            case .LOGICAL_AND:
//                return "AND operator"
//            case .LOGICAL_OR:
//                return "OR operator"
//            case .LOGICAL_NOT:
//                return "NOT oeprator"
//            case .OPEN_BRACKET:
//                return "open bracket"
//            case .CLOSE_BRACKET:
//                return "close bracket"
//            case .STRING:
//                return "tag"
//            }
//        }
//    }
//    
//    let type: Type
////    let tokenType: TokenType
//    let value: String
//    let startOffset: Int
//    let endOffset: Int
//    let lineNumber: Int
//    let columnNumber: Int
//    
//    init(type: Type, value: String, startOffset: Int, endOffset: Int, lineNumber: Int, columnNumber: Int) {
////    init(tokenType: TokenType, value: String, startOffset: Int, endOffset: Int, lineNumber: Int, columnNumber: Int) {
//        self.type = type
////        self.tokenType = tokenType
//        self.value = value
//        self.startOffset = startOffset
//        self.endOffset = endOffset
//        self.lineNumber = lineNumber
//        self.columnNumber = columnNumber
//    }
//    
//    func equals(obj: AnyObject) -> Bool {
//        if let token = obj as? Token {
//            return self == token
//        } else {
//            return false
//        }
//    }
//    
//// NOTE: moved this to be a property of the enum
////    class func typeDescription(type: Type) -> String {
//////    class func typeDescription(tokenType: TokenType) -> String {
////        switch type {
//////        switch tokenType {
////        case .LOGICAL_AND:
////            return "AND operator"
////        case .LOGICAL_OR:
////            return "OR operator"
////        case .LOGICAL_NOT:
////            return "NOT oeprator"
////        case .OPEN_BRACKET:
////            return "open bracket"
////        case .CLOSE_BRACKET:
////            return "close bracket"
////        case .STRING:
////            return "tag"
////        }
////    }
//}
//
//// Conform to Equatable
//extension Token: Equatable {
//}
//@infix func ==(lhs: Token, rhs: Token) -> Bool {
//    return lhs.type == rhs.type
////    return lhs.tokenType == rhs.tokenType
//        && lhs.value == rhs.value
//        && lhs.startOffset == rhs.startOffset
//        && lhs.endOffset == rhs.endOffset
//        && lhs.lineNumber == rhs.lineNumber
//        && lhs.columnNumber == rhs.columnNumber
}
