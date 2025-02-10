# Use when configuring Lambda@Edge for origin-request
data "archive_file" "example_origin_request_lambda" {
  type        = "zip"
  source_file = "./lambda/origin_request.js"
  output_path = "./origin_request.zip"
}

resource "aws_lambda_function" "example_origin_request" {
  function_name    = "example-function-origin-request"
  role             = aws_iam_role.example.arn
  runtime          = "nodejs20.x"
  handler          = "origin_request.handler"
  filename         = "./origin_request.zip"
  source_code_hash = data.archive_file.example_origin_request_lambda.output_base64sha256
  publish          = true
  timeout          = 30

  provider = aws.us-east-1
}

