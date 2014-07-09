protocol RendererProtocol {
    /// Render an expression to a string.
    func render<T: ExpressionProtocol>(expression: T) -> String
}
