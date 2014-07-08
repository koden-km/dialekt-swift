class ExpressionRenderer: RendererProtocol, VisitorProtocol {
    // how to set the visitor type?
    // VisitorProtocol where VisitorProtocol.VisitResultType = String
//    typealias VisitorProtocol.VisitResultType = String
    typealias VisitResultType = String

    let _wildcardString: String
    
    init(wildcardString: String?) {
        if wildcardString {
            _wildcardString = wildcardString!
        } else {
            _wildcardString = Token_WILDCARD_CHARACTER
        }
    }
    
    /// Render an expression to a string.
    func render(expression: ExpressionProtocol) -> String {
        return expression.accept(expression)
    }
    
    /// Visit a LogicalAnd node.
    func visitLogicalAnd(node: LogicalAnd) -> String {
        return _implodeNodes("AND", node.children())
    }

    /// Visit a LogicalOr node.
    func visitLogicalOr(node: LogicalOr) -> String {
        return _implodeNodes("OR", node.children())
    }
    
    /// Visit a LogicalNot node.
    func visitLogicalNot(node: LogicalNot) -> String {
        return "NOT " + node.child().accept(self)
    }
    
    /// Visit a Tag node.
    func visitTag(node: Tag) -> String {
        return _escapeString(node.name())
    }
    
    /// Visit a pattern node.
    func visitPattern(node: Pattern) -> String {
        var string = ""
        
        for n in node.children() {
            string += n.accept(self)
        }
        
        return _escapeString(string)
    }
    
    /// Visit a PatternLiteral node.
    func visitPatternLiteral(node: PatternLiteral) -> String {

// TODO: how to do this in Swift?
//        if (node.string().contains(this.wildcardString)) {
//            throw new RenderException(
//                String.format(
//                    "The pattern literal \"%s\" contains the wildcard string \"%s\".",
//                    node.string(),
//                    this.wildcardString
//                )
//            );
//        }
        
        return node.string()
    }
    
    /// Visit a PatternWildcard node.
    func visitPatternWildcard(node: PatternWildcard) -> String {
        return _wildcardString
    }
    
    /// Visit a EmptyExpression node.
    func visitEmptyExpression(node: EmptyExpression) -> String {
        return "NOT " + _wildcardString
    }
    
    func _implodeNodes(separator: String, nodes: ExpressionProtocol[]) -> String {
        var result = ""
        
        for node in nodes {
            if !result.isEmpty {
                result += " " + separator + " "
            }
            
            result += node.accept(self)
        }
        
        return result
    }
    
    func _escapeString(string: String) -> String {
        
// TODO
//        if (
//            "and".equalsIgnoreCase(string)
//                || "or".equalsIgnoreCase(string)
//                || "not".equalsIgnoreCase(string)
//            ) {
//                return '"' + string + '"';
//        }
//        
//        String[] characters = { "\\", "(", ")", "\"" };
//        
//        for (String s : characters) {
//            string = string.replace(s, '\\' + s);
//        }
//        
//        if (string.matches(".*[\\s\\\\].*")) {
//            return '"' + string + '"';
//        }
//        
//        return string;

        return "TODO"
    }
}
