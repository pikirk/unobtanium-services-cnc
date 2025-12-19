data "aws_iam_policy_document" "lambda_assume_role_policy" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "lambda_execution_role" {
  name               = "${var.lambda_function_name}-execution-role-${local.env}"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role_policy.json

  tags = {
    Name = "Lambda Execution Role for ${var.lambda_function_name}-${local.env}"
  }
}

data "aws_iam_policy_document" "lambda_logging" {
  statement {
    effect = "Allow"

    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]

    resources = [
      "arn:aws:logs:${local.aws_region}:*:log-group:/aws/lambda/${var.lambda_function_name}-${local.env}:*"
    ]
  }
}

resource "aws_iam_policy" "lambda_logging_policy" {
  name        = "${var.lambda_function_name}-logging-policy-${local.env}"
  description = "IAM policy for Lambda CloudWatch Logs"
  policy      = data.aws_iam_policy_document.lambda_logging.json
}

resource "aws_iam_role_policy_attachment" "lambda_logging" {
  role       = aws_iam_role.lambda_execution_role.name
  policy_arn = aws_iam_policy.lambda_logging_policy.arn
}

# If your Lambda needs to access other AWS services (DynamoDB, S3, etc.), add additional policies here
# Example: DynamoDB access
# data "aws_iam_policy_document" "lambda_dynamodb" {
#   statement {
#     effect = "Allow"
#     actions = [
#       "dynamodb:GetItem",
#       "dynamodb:Query",
#       "dynamodb:Scan"
#     ]
#     resources = ["arn:aws:dynamodb:${var.aws_region}:*:table/engravers"]
#   }
# }
#
# resource "aws_iam_policy" "lambda_dynamodb" {
#   name   = "${var.lambda_function_name}-dynamodb-policy-${var.environment}"
#   policy = data.aws_iam_policy_document.lambda_dynamodb.json
# }
#
# resource "aws_iam_role_policy_attachment" "lambda_dynamodb" {
#   role       = aws_iam_role.lambda_execution.name
#   policy_arn = aws_iam_policy.lambda_dynamodb.arn
# }