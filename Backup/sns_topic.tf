resource "aws_sns_topic" "ue133_alerting_2" {
  name = "ue133_alerting_2"
}

resource "aws_sns_topic_subscription" "email_subscription" {
  topic_arn = aws_sns_topic.ue133_alerting_2.arn
  protocol  = "email"
  endpoint  = "christian.altenhofer@docc.techstarter.de"
}
