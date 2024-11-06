output "api_url" {
  description = "URL de la API Gateway en LocalStack"
  value = "${var.localstack_endpoint_url}/restapis/${aws_api_gateway_rest_api.products_api.id}/dev/_user_request_/products"
}