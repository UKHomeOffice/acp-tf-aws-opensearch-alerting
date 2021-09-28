resource "aws_lambda_function" "slack_lambda" {
  filename      = data.archive_file.file.output_path
  function_name = "${var.opensearch_domain}-lambda-notify-slack"
  role          = aws_iam_role.lambda_role.arn
  handler       = var.lambda_handler

  source_code_hash = data.archive_file.file.output_base64sha256
  runtime = var.runtime

  environment {
    variables = {
      kmsEncryptedHookUrl = var.slack_url
      slackChannel = var.slack_channel
    }
  }
  depends_on = [
    data.archive_file.file
  ]
}

data "archive_file" "file" {
  type        = "zip"
  source_file = "${path.module}/slack_alert.py"
  output_path = "${path.module}/lambda_function.zip"
}