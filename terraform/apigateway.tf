resource "aws_api_gateway_rest_api" "products_api" {
  name        = "ProductsAPI"
  description = "API Gateway for managing products"
}

resource "aws_api_gateway_resource" "products_resource" {
  rest_api_id = aws_api_gateway_rest_api.products_api.id
  parent_id   = aws_api_gateway_rest_api.products_api.root_resource_id
  path_part   = "products"
}

resource "aws_api_gateway_method" "get_products" {
  rest_api_id   = aws_api_gateway_rest_api.products_api.id
  resource_id   = aws_api_gateway_resource.products_resource.id
  authorization = "NONE"
  http_method   = "GET"
}

resource "aws_api_gateway_integration" "get_products_integration" {
  rest_api_id = aws_api_gateway_rest_api.products_api.id
  resource_id = aws_api_gateway_resource.products_resource.id
  http_method = aws_api_gateway_method.get_products.http_method

  integration_http_method = "POST"
  type                    = "AWS_PROXY"    
  uri                     = "arn:aws:apigateway:us-east-1:lambda:path/2015-03-31/functions/arn:aws:lambda:us-east-1:000000000000:function:productHandler/invocations"
}

resource "aws_api_gateway_deployment" "products_api_deployment" {
  rest_api_id = aws_api_gateway_rest_api.products_api.id
  stage_name = "dev"

  depends_on = [ 
    aws_api_gateway_integration.get_products_integration,
    aws_api_gateway_method.get_products
  ]
}