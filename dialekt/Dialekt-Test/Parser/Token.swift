// Note: class (static) variables not yet supported in Swift apparently.
let Token_WILDCARD_CHARACTER = "*"

class Token {
    //class let WILDCARD_CHARACTER = "*"

//    enum `Type`: Int {
    enum TokenType: Int {
        case
        LOGICAL_AND   = 1,
        LOGICAL_OR    = 2,
        LOGICAL_NOT   = 3,
        STRING        = 4,
        OPEN_BRACKET  = 6,
        CLOSE_BRACKET = 7
    }
}
