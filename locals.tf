locals {
  instance_types = {
    "i3.large.elasticsearch"   = 475000
    "i3.xlarge.elasticsearch"  = 950000
    "i3.2xlarge.elasticsearch" = 1900000
    "i3.4xlarge.elasticsearch" = 3800000
    "i3.8xlarge.elasticsearch" = 7600000
  }

  # Alarms that indicate ingestion has stopped or is about to stop are also sent to email.
  alarm_actions_with_email          = distinct(concat(var.alarm_actions, var.email_alarm_actions))
  critical_alarm_actions_with_email = distinct(concat(var.critical_alarm_actions, var.email_alarm_actions))
}
