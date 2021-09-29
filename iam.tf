resource "aws_iam_role" "lambda_role" {
  name               = "${var.opensearch_domain}-lambda-role"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role.json
  managed_policy_arns = ["arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"]
  inline_policy {
    name = "kms-decrypt"
    policy = data.aws_iam_policy_document.lambda_kms_policy.json
  }  
}

data "aws_iam_policy_document" "lambda_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      identifiers = ["lambda.amazonaws.com"]
      type        = "Service"
    }
  }
}

data "aws_iam_policy_document" "lambda_kms_policy" {
  statement {
    actions = ["kms:decrypt"]
    resources = [
      "*",
    ]
  }
}