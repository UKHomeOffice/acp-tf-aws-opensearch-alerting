resource "aws_sns_topic" "opsgenie" {
  name            = "${var.opensearch_domain}-opsgenie-notification"
}

resource "aws_sns_topic" "slack" {
  name            = "${var.opensearch_domain}-slack-notification"
}

resource "aws_sns_topic" "email" {
  name            = "${var.opensearch_domain}-email-notification"
}

resource "aws_sns_topic_subscription" "opsgenie" {
  topic_arn = aws_sns_topic.opsgenie.arn
  endpoint = var.opsgenie_url
  protocol = "https"
}

resource "aws_sns_topic_subscription" "slack" {
  topic_arn = aws_sns_topic.slack.arn
  endpoint = aws_lambda_function.slack_lambda.arn
  protocol = "lambda"
}

resource "aws_sns_topic_subscription" "email" {
  topic_arn = aws_sns_topic.email.arn
  endpoint = var.email_address
  protocol = "email"
}
