output "lambda_function_arn" {
  description = "ARN of the Lambda function"
  value       = aws_lambda_function.engraver_handler.arn
}

output "lambda_function_name" {
  description = "Name of the Lambda function"
  value       = aws_lambda_function.engraver_handler.function_name
}

output "lambda_invoke_arn" {
  description = "Invoke ARN of the Lambda function (for API Gateway integration)"
  value       = aws_lambda_function.engraver_handler.invoke_arn
}

output "lambda_execution_role_arn" {
  description = "ARN of the Lambda execution role"
  value       = aws_iam_role.lambda_execution_role.arn
}

output "lambda_artifacts_bucket_name" {
  description = "Name of the S3 bucket for Lambda artifacts"
  value       = aws_s3_bucket.lambda_artifacts.id
}

output "lambda_artifacts_bucket_arn" {
  description = "ARN of the S3 bucket for Lambda artifacts"
  value       = aws_s3_bucket.lambda_artifacts.arn
}

output "api_gateway_id" {
  description = "ID of the API Gateway"
  value       = data.aws_apigatewayv2_api.main.id
}

output "api_gateway_endpoint" {
  description = "API Gateway endpoint URL"
  value       = data.aws_apigatewayv2_api.main.api_endpoint
}

output "engraver_routes" {
  description = "Engraver API routes"
  value = {
    list_engravers     = "${data.aws_apigatewayv2_api.main.api_endpoint}/engraver"
    get_engraver_by_id = "${data.aws_apigatewayv2_api.main.api_endpoint}/engraver/{id}"
  }
}