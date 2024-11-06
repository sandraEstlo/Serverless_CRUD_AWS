resource "aws_lambda_function" "product_handler" {
  role             = aws_iam_role.lambda_role.arn
  function_name    = "productHandler"
  runtime          = "python3.8"
  handler          = "handler.lambda_handler"
  filename         = "/workspace/lambda/handler.zip"
  source_code_hash = filebase64sha256("/workspace/lambda/handler.zip")

  environment {
    variables = {
      TABLE_NAME             = aws_dynamodb_table.products.name
      AWS_ACCESS_KEY_ID      = var.access_key
      AWS_SECRET_ACCESS_KEY  = var.secret_key
      AWS_REGION             = var.region
    }
  }

  depends_on = [aws_dynamodb_table.products]
}

output "terraform_aws_arn_output" {
  value = aws_iam_role.lambda_role
}