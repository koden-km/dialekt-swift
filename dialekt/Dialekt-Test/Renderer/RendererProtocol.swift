protocol RendererProtocol {
    /// Render an expression to a string.
    func render(expression: ExpressionProtocol) -> String
}
