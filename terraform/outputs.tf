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