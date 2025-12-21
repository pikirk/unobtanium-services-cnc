# data block to look up existing API Gateway
data "aws_apigatewayv2_api" "gateway_lookup" {
  api_id = var.api_gateway_identifier
}

# data block to look up existing S3 artifacts bucket
data "aws_s3_bucket" "s3_bucket_lookup" {
  bucket = var.lambda_artifacts_bucket_name
}

resource "aws_lambda_function" "engraver_handler" {
  function_name = var.lambda_function_name
  role          = aws_iam_role.lambda_execution_role.arn
  handler       = var.lambda_handler
  runtime       = var.lambda_runtime

  # data lookup for S3 bucket ID
  s3_bucket = data.aws_s3_bucket.s3_bucket_lookup.id 
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
    aws_iam_role_policy_attachment.lambda_logging
  ]

  tags = merge(local.tags, {
    Name = "Engraver Handler Lambda"
  })
}

resource "aws_cloudwatch_log_group" "lambda" {
  name              = "/aws/lambda/${var.lambda_function_name}-${local.env}"
  retention_in_days = 3

  tags = merge(local.tags, {
    Name = "Engraver Handler Logs"
  })
}

# lambda permission for API Gateway to invoke
resource "aws_lambda_permission" "api_gateway" {
  statement_id  = "AllowAPIGatewayInvoke-${vars.lambda_function_name}"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.engraver_handler.function_name
  principal     = "apigateway.amazonaws.com"

  # data lookup for API Gateway execution ARN
  source_arn    = "${data.aws_apigatewayv2_api.gateway_lookup.execution_arn}/*/*"
}