resource "aws_lambda_function" "slack_lambda" {
  filename      = data.archive_file.file.output_path
  function_name = "${var.opensearch_domain}-lambda-notify-slack"
  role          = aws_iam_role.lambda_role.arn
  handler       = var.lambda_handler

  source_code_hash = data.archive_file.file.output_base64sha256
  runtime = var.runtime
  timeout = var.timeout
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

resource "aws_lambda_permission" "lambda_sns" {
  statement_id  = "AllowExecutionFromSNS"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.slack_lambda.function_name
  principal     = "sns.amazonaws.com"
  source_arn    = aws_sns_topic.slack.arn
}

data "archive_file" "file" {
  type        = "zip"
  source_file = "${path.module}/slack_alert.py"
  output_path = "${path.module}/lambda_function.zip"
}