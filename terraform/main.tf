provider "aws" {
  region     = var.region
  access_key = var.access_key
  secret_key = var.secret_key
  
  skip_credentials_validation  = true

  endpoints {
    iam        = "http://127.0.0.1:4566"
    apigateway = "http://127.0.0.1:4566"
    dynamodb   = "http://127.0.0.1:4566"
    lambda     = "http://127.0.0.1:4566"
  }
}

output "api_url" {
  description = "URL de la API Gateway en LocalStack"
  value = "http://127.0.0.1:4566/restapis/${aws_api_gateway_rest_api.products_api.id}/dev/_user_request_/products"
}