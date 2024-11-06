variable "access_key" {
	default = "test"
}

variable "secret_key" {
	default = "test"
}

variable "region" {
    default = "us-east-1"
}

variable "dynamodb_table_name" {
  description = "Nombre de la tabla DynamoDB"
  default     = "Products"
}

variable "localstack_lambda_account_id" {
  default = "000000000000"
}

variable "localstack_endpoint_url" {
  default = "http://localstack:4566"
}