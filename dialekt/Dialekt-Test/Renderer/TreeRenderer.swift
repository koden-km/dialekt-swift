///// Render an AST expression to a string representing the tree structure.
//class TreeRenderer: RendererProtocol, VisitorProtocol {
//    //  where ExpressionVisitorProtocol.VisitResultTypeExpression = PatternChildVisitorProtocol.VisitResultTypePattern
//    
//    let _endOfLine: String
//    
//    init(endOfLine: String?) {
//        if endOfLine {
//            _endOfLine = endOfLine!
//        } else {
//            _endOfLine = "\n"
//        }
//    }
//    
//    /// Get the end-of-line string.
//    func endOfLine() -> String {
//        return _endOfLine
//    }
//    
//    /// Render an expression to a string.
//    func render(expression: ExpressionProtocol) -> String {
//        return expression.accept(self)
//    }
//    
//    /// Visit a LogicalAnd node.
//    func visitLogicalAnd(node: LogicalAnd) -> String {
////        return "AND" + _endOfLine +
//    }
//
//    /// Visit a LogicalOr node.
//    func visitLogicalOr(node: LogicalOr) -> String {
//        return "OR" + _endOfLine + _renderChildren(node.children())
//    }
//    
//    /// Visit a LogicalNot node.
//    func visitLogicalNot(node: LogicalNot) -> String {
//        return "NOT" + _endOfLine + _indent("- " + node.child().accept(self))
//    }
//    
//    /// Visit a Tag node.
//    func visitTag(node: Tag) -> String {
//        return "TAG " + _encodeString(node.name())
//    }
//    
//    /// Visit a Pattern node.
//    func visitPattern(node: Pattern) -> String {
//        return "PATTERN" + _endOfLine + _renderChildren(node.children())
//
////        var x: [NodeProtocol]
////        x = node.children()
////        return "PATTERN" + _endOfLine + _renderChildren(x)
//    }
//    
//    /// Visit a PatternLiteral node.
//    func visitPatternLiteral(node: PatternLiteral) -> String {
//        return "LITTERAL" + _encodeString(node.string())
//    }
//    
//    /// Visit a PatternWildcard node.
//    func visitPatternWildcard(node: PatternWildcard) -> String {
//        return "WILDCARD"
//    }
//    
//    /// Visit a EmptyExpression node.
//    func visitEmptyExpression(node: EmptyExpression) -> String {
//        return "EMPTY"
//    }
//    
////    func _renderChildren(children: Sequence) -> String {
////    func _renderChildren<T: NodeProtocol>(children: SequenceOf<T>) -> String {
//    func _renderChildren<T: NodeProtocol>(children: [T]) -> String {
////    func _renderChildren(children: SequenceOf<NodeProtocol>) -> String {
////    func _renderChildren(children: [NodeProtocol]) -> String {
//        var output = ""
//        
//        for n in children {
//            output += _indent("- " + n.accept(self)) + _endOfLine
//        }
//
//// TODO
////        return output.substring(
////            0,
////            output.length() - this.endOfLine.length()
////        );
//
//        return "TODO"
//    }
//    
//    func _indent(string: String) -> String {
////        return "  " + string.replace(this.endOfLine, "  " + this.endOfLine);
//
//        return "TODO"
//    }
//    
//    func _encodeString(string: String) -> String {
////        return JSONObject.quote(string);
//
//        return "TODO"
//    }
//}
