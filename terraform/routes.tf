# Lambda integration
resource "aws_apigatewayv2_integration" "engraver_handler" {
  api_id = data.aws_apigatewayv2_api.main.id

  integration_uri        = aws_lambda_function.engraver_handler.invoke_arn
  integration_type       = "AWS_PROXY"
  integration_method     = "POST"
  payload_format_version = "2.0"

  description = "Integration for engraver handler Lambda (${local.env})"
}

# Route: GET /engraver (list all engravers with pagination)
resource "aws_apigatewayv2_route" "get_engravers" {
  api_id    = data.aws_apigatewayv2_api.main.id
  route_key = "GET /engraver"
  target    = "integrations/${aws_apigatewayv2_integration.engraver_handler.id}"
}

# Route: GET /engraver/{id} (get specific engraver)
resource "aws_apigatewayv2_route" "get_engraver_by_id" {
  api_id    = data.aws_apigatewayv2_api.main.id
  route_key = "GET /engraver/{id}"
  target    = "integrations/${aws_apigatewayv2_integration.engraver_handler.id}"
}

# Lambda permission for API Gateway to invoke the function
resource "aws_lambda_permission" "api_gateway_invoke" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.engraver_handler.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${data.aws_apigatewayv2_api.main.execution_arn}/*/*"
}