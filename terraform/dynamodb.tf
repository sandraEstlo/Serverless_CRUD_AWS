resource "aws_dynamodb_table" "products" {
  name         = var.dynamodb_table_name
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "id"

  attribute {
    name = "id"
    type = "S"
  }
}

# resource "aws_dynamodb_table_item" "product1" {
#   table_name = var.dynamodb_table_name
#   hash_key   = "id"
#   item       = <<EOT
#     {
#       "id": {"S": "1"},
#       "name": {"S": "Product 1"},
#       "description": {"S": "This is the first product."}
#     }
#   EOT
# }

# resource "aws_dynamodb_table_item" "product2" {
#   table_name = var.dynamodb_table_name
#   hash_key   = "id"
#   item       = <<EOT
#     {
#       "id": {"S": "2"},
#       "name": {"S": "Product 2"},
#       "description": {"S": "This is the second product."}
#     }
#   EOT
# } 
