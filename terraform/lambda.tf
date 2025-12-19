resource "aws_lambda_function" "engraver_handler" {
  function_name = "${var.lambda_function_name}"
  role          = aws_iam_role.lambda_execution_role.arn
  handler       = var.lambda_handler
  runtime       = var.lambda_runtime

  s3_bucket = aws_s3_bucket.lambda_artifacts.id
  s3_key    = var.lambda_artifact_key

  timeout     = var.lambda_timeout_secs
  memory_size = var.lambda_memory_size_mb

  environment {
    variables = {
      ENVIRONMENT = local.env
      LOG_LEVEL   = "INFO"
    }
  }

  # AWS X-Ray tracing
  tracing_config {
    mode = "Active"  
  }

  depends_on = [
    aws_iam_role_policy_attachment.lambda_logging,
    aws_s3_bucket.lambda_artifacts_bucket_name
  ]

  tags = {
    Name        = "Engraver Handler Lambda"
    Environment = local.env
  }
}

resource "aws_cloudwatch_log_group" "lambda" {
  name              = "/aws/lambda/${var.lambda_function_name}-${local.env}"
  retention_in_days = 3

  tags = {
    Name        = "Engraver Handler Logs"
    Environment = local.env
  }
}

# Lambda permission for API Gateway to invoke (will be created in core-infrastructure)
# This is just a placeholder comment showing what core-infrastructure will need:
# resource "aws_lambda_permission" "api_gateway" {
#   statement_id  = "AllowAPIGatewayInvoke"
#   action        = "lambda:InvokeFunction"
#   function_name = aws_lambda_function.engraver_handler.function_name
#   principal     = "apigateway.amazonaws.com"
#   source_arn    = "${data.aws_api_gateway_rest_api.main.execution_arn}/*/*"
# }