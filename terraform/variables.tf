variable "env" {
  description = "Environment name (dev, staging, prod)"
  type        = string
  default     = "dev"
}

variable "lambda_artifacts_bucket_name" {
  description = "Name of S3 bucket for Lambda deployment artifacts"
  type        = string
  default     = "engraver-lambda-artifacts"
}

variable "lambda_function_name" {
  description = "Name of the Lambda function"
  type        = string
  default     = "engraver-handler"
}

variable "lambda_runtime" {
  description = "Lambda runtime version"
  type        = string
  default     = "nodejs20.x"
}

variable "lambda_timeout_secs" {
  description = "Lambda timeout in seconds"
  type        = number
  default     = 30
}

variable "lambda_memory_size_mb" {
  description = "Lambda memory size in MB"
  type        = number
  default     = 256
}

variable "lambda_handler" {
  description = "Lambda handler path"
  type        = string
  default     = "index.handler"
}

variable "lambda_artifact_key" {
  description = "S3 key for Lambda deployment package"
  type        = string
  default     = "handlers/engraver-handler.zip"
}

variable "api_gateway_identifier" {
  description = "Name of the existing API Gateway to attach routes to"
  type        = string
}

variable "lambda_package_file_name" {
  description = "Name of the Lambda package file"
  type        = string
}