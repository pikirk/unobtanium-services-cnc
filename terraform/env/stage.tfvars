env                          = "stage"
lambda_artifacts_bucket_name = "lambda-artifacts-engraver-stage"
lambda_function_name         = "engraver-handler-stage"
lambda_runtime               = "nodejs20.x"
lambda_timeout_secs          = 30
lambda_memory_size_mb        = 256
lambda_handler               = "index.handler"
lambda_artifact_key          = "handlers/engraver-handler.zip"