provider "aws" {
  region     = var.region
  access_key = var.access_key
  secret_key = var.secret_key
  
  skip_credentials_validation  = true

  endpoints {
    iam        = "${var.localstack_endpoint_url}"
    apigateway = "${var.localstack_endpoint_url}"
    dynamodb   = "${var.localstack_endpoint_url}"
    lambda     = "${var.localstack_endpoint_url}"
  }
}