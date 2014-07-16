class ExpressionRenderer: RendererProtocol, VisitorProtocol {
    
    init(wildcardString: String) {
        _wildcardString = wildcardString
    }
    
    convenience init() {
        self.init(wildcardString: "*")
    }

    func render(expression: ExpressionProtocol) -> String {
            return expression.accept(self)
    }
    
    func visitLogicalAnd(node: LogicalAnd) -> String {
        return _implodeNodes("AND", nodes: node.children())
    }

    func visitLogicalOr(node: LogicalOr) -> String {
        return _implodeNodes("OR", nodes: node.children())
    }

    func visitLogicalNot(node: LogicalNot) -> String {
        return "NOT " + node.child().accept(self)
    }

    func visitTag(node: Tag) -> String {
        return _escapeString(node.name())
    }

    func visitPattern(node: Pattern) -> String {
        return "".join(
            node.children().map() {
                $0.accept(self)
            }
        )
    }

    func visitEmptyExpression(node: EmptyExpression) -> String {
        return "NOT " + _wildcardString
    }

    func visitPatternLiteral(node: PatternLiteral) -> String {
        // TODO: fail if node.string() contains wildcard
        return _escapeString(node.string())
    }

    func visitPatternWildcard(node: PatternWildcard) -> String {
        return _wildcardString
    }

    func _implodeNodes(separator: String, nodes: [ExpressionProtocol]) -> String {
        return (" " + separator + " ").join(
            nodes.map() {
                $0.accept(self)
            }
        )
    }

    func _escapeString(string: String) -> String {
        // TODO
        return string
    }

    let _wildcardString: String
}

