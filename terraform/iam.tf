resource "aws_iam_role" "lambda_role" {
  name = "lambda_dynamodb_role"

  assume_role_policy = <<EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": "sts:AssumeRole",
        "Principal": {
          "Service": "lambda.amazonaws.com"
        },
        "Effect": "Allow",
        "Sid": ""
      }
    ]
  }
  EOF
}

resource "aws_iam_policy" "dynamodbFullAccessPolicy" {
  name        = "dynamodb_Policy"
  description = " Dynamodb Full Access policy for Lambda"

  policy = <<EOF
    {
      "Version": "2012-10-17",
      "Statement": [
        {
          "Effect": "Allow",
          "Action": [
            "dynamodb:PutItem",
            "dynamodb:GetItem",
            "dynamodb:UpdateItem",
            "dynamodb:DeleteItem",
            "dynamodb:Scan",
            "dynamodb:Query"
          ],
          "Resource": "*"
        }
      ]
    }
    EOF
}

resource "aws_iam_policy_attachment" "dynamodb_role_attachment" {
  name       = "dynamodb_role"
  policy_arn = aws_iam_policy.dynamodbFullAccessPolicy.arn
  roles      = [aws_iam_role.lambda_role.name]
}
