resource "aws_cloudwatch_metric_alarm" "kinesis_get_records_success" {
  count                     = var.kinesis_alarms_required ? 1 : 0
  alarm_name                = "${var.alert_level}-${var.kinesis_stream_name}-kinesis-get-record-success"
  comparison_operator       = "LessThanOrEqualToThreshold"
  metric_name               = "GetRecords.Success"
  namespace                 = "AWS/Kinesis"
  statistic                 = "Average"
  evaluation_periods        = var.get_records_success_evaluation_periods
  period                    = var.get_records_success_period
  threshold                 = var.get_records_success_threshold
  alarm_description         = "The ${var.alert_level} alarm to monitor the kinesis successful GetRecords operations for ${var.kinesis_stream_name}"
  alarm_actions             = var.alarm_actions
  dimensions = {
    StreamName = var.kinesis_stream_name
  }
}

resource "aws_cloudwatch_metric_alarm" "kinesis_put_records_success" {
  count                     = var.kinesis_alarms_required ? 1 : 0
  alarm_name                = "${var.alert_level}-${var.kinesis_stream_name}-kinesis-put-record-success"
  comparison_operator       = "LessThanOrEqualToThreshold"
  metric_name               = "PutRecords.Success"
  namespace                 = "AWS/Kinesis"
  statistic                 = "Average"
  evaluation_periods        = var.put_records_success_evaluation_periods
  period                    = var.put_records_success_period
  threshold                 = var.put_records_success_threshold
  alarm_description         = "The ${var.alert_level} alarm to monitor the kinesis successful PutRecords operations for ${var.kinesis_stream_name}"
  alarm_actions             = var.alarm_actions
  dimensions = {
    StreamName = var.kinesis_stream_name
  }
}

resource "aws_cloudwatch_metric_alarm" "kinesis_get_iterator_age" {
  count                     = var.kinesis_alarms_required ? 1 : 0
  alarm_name                = "${var.alert_level}-${var.kinesis_stream_name}-kinesis-iterator-age"
  comparison_operator       = "LessThanOrEqualToThreshold"
  evaluation_periods        = var.get_iterator_evaluation_periods
  metric_name               = "GetRecords.IteratorAgeMilliseconds"
  namespace                 = "AWS/Kinesis"
  period                    = var.get_iterator_period
  statistic                 = "Average"
  threshold                 = var.get_iterator_threshold
  alarm_description         = "The ${var.alert_level} alarm to monitor the kinesis get iterator age metric for ${var.kinesis_stream_name}"
  alarm_actions             = var.alarm_actions
  dimensions = {
    StreamName = var.kinesis_stream_name
  }
}

resource "aws_cloudwatch_metric_alarm" "kinesis_read_throughput" {
  count                     = var.kinesis_alarms_required ? 1 : 0
  alarm_name                = "${var.alert_level}-${var.kinesis_stream_name}-kinesis-read-throughput"
  comparison_operator       = "LessThanOrEqualToThreshold"
  evaluation_periods        = var.read_throughput_evaluation_periods
  metric_name               = "ReadProvisionedThroughputExceeded"
  namespace                 = "AWS/Kinesis"
  period                    = var.read_throughput_period
  statistic                 = "Average"
  threshold                 = var.read_throughput_threshold
  alarm_description         = "The ${var.alert_level} alarm to monitor the kinesis get iterator age metric for ${var.kinesis_stream_name}"
  alarm_actions             = var.alarm_actions
  dimensions = {
    StreamName = var.kinesis_stream_name
  }
}

resource "aws_cloudwatch_metric_alarm" "kinesis_write_throughput" {
  count                     = var.kinesis_alarms_required ? 1 : 0
  alarm_name                = "${var.alert_level}-${var.kinesis_stream_name}-kinesis-write-throughput"
  comparison_operator       = "LessThanOrEqualToThreshold"
  evaluation_periods        = var.write_throughput_evaluation_periods
  metric_name               = "WriteProvisionedThroughputExceeded"
  namespace                 = "AWS/Kinesis"
  period                    = var.write_throughput_period
  statistic                 = "Average"
  threshold                 = var.write_throughput_threshold
  alarm_description         = "The ${var.alert_level} alarm to monitor the kinesis get iterator age metric for ${var.kinesis_stream_name}"
  alarm_actions             = var.alarm_actions
  dimensions = {
    StreamName = var.kinesis_stream_name
  }
}

resource "aws_cloudwatch_metric_alarm" "cluster_yellow" {
  count                     = var.opensearch_alarms_required ? 1 : 0
  alarm_name                = "warning-${var.opensearch_domain}-opensearch-cluster-yellow"
  comparison_operator       = "LessThanOrEqualToThreshold"
  evaluation_periods        = "1"
  metric_name               = "ClusterStatus.yellow"
  namespace                 = "AWS/ES"
  period                    = "60"
  statistic                 = "Maximum"
  threshold                 = "1"
  alarm_description         = "The ${var.alert_level} alarm to monitor the AWS Opensearch cluster status is yellow for ${var.opensearch_domain}"
  alarm_actions             = var.alarm_actions
  dimensions = {
    DomainName = var.opensearch_domain
    ClientId   = data.aws_caller_identity.current.account_id
  }
}

resource "aws_cloudwatch_metric_alarm" "cluster_red" {
  count                     = var.opensearch_alarms_required ? 1 : 0
  alarm_name                = "critical-${var.opensearch_domain}-opensearch-cluster-red"
  comparison_operator       = "LessThanOrEqualToThreshold"
  evaluation_periods        = "1"
  metric_name               = "ClusterStatus.red"
  namespace                 = "AWS/ES"
  period                    = "60"
  statistic                 = "Maximum"
  threshold                 = "1"
  alarm_description         = "The ${var.alert_level} alarm to monitor the AWS Opensearch cluster status is red for ${var.opensearch_domain}"
  alarm_actions             = var.alarm_actions
  dimensions = {
    DomainName = var.opensearch_domain
    ClientId   = data.aws_caller_identity.current.account_id
  }
}

resource "aws_cloudwatch_metric_alarm" "cpu_utilization_alert" {
  count                     = var.opensearch_alarms_required ? 1 : 0
  alarm_name                = "${var.alert_level}-${var.opensearch_domain}-opensearch-cpu-utlization"
  comparison_operator       = "LessThanOrEqualToThreshold"
  evaluation_periods        = var.cpu_utilization_evaluation_periods
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/ES"
  period                    = var.cpu_utilization_period
  statistic                 = "Maximum"
  threshold                 = var.cpu_utilization_threshold
  alarm_description         = "The ${var.alert_level} alarm to monitor the ${var.opensearch_domain} AWS Opensearch cluster cpu utilization is not consistently above ${var.cpu_utilization_threshold}%"
  alarm_actions             = var.alarm_actions
  dimensions = {
    DomainName = var.opensearch_domain
    ClientId   = data.aws_caller_identity.current.account_id
  }
}

resource "aws_cloudwatch_metric_alarm" "jvm_pressure" {
  count                     = var.opensearch_alarms_required ? 1 : 0
  alarm_name                = "${var.alert_level}-${var.opensearch_domain}-opensearch-jvm-pressure"
  comparison_operator       = "LessThanOrEqualToThreshold"
  evaluation_periods        = var.jvm_evaluation_periods
  metric_name               = "JVMMemoryPressure"
  namespace                 = "AWS/ES"
  period                    = var.jvm_period
  statistic                 = "Maximum"
  threshold                 = var.jvm_threshold
  alarm_description         = "The ${var.alert_level} alarm to monitor the ${var.opensearch_domain} AWS Opensearch cluster jvm pressure is not above ${var.jvm_threshold}%"
  alarm_actions             = var.alarm_actions
  dimensions = {
    DomainName = var.opensearch_domain
    ClientId   = data.aws_caller_identity.current.account_id
  }
}

resource "aws_cloudwatch_metric_alarm" "master_cpu_utilization" {
  count                     = var.opensearch_alarms_required ? 1 : 0
  alarm_name                = "${var.alert_level}-${var.opensearch_domain}-opensearch-master-cpu-utlization"
  comparison_operator       = "LessThanOrEqualToThreshold"
  evaluation_periods        = var.master_cpu_utilization_evaluation_periods
  metric_name               = "MasterCPUUtilization"
  namespace                 = "AWS/ES"
  period                    = var.master_cpu_utilization_period
  statistic                 = "Maximum"
  threshold                 = var.master_cpu_utilization_threshold
  alarm_description         = "The ${var.alert_level} alarm to monitor the ${var.opensearch_domain} AWS Opensearch cluster cpu utilization is not consistently above ${var.master_cpu_utilization_threshold}%"
  alarm_actions             = var.alarm_actions
  dimensions = {
    DomainName = var.opensearch_domain
    ClientId   = data.aws_caller_identity.current.account_id
  }
}

resource "aws_cloudwatch_metric_alarm" "master_jvm_pressure" {
  count                     = var.opensearch_alarms_required ? 1 : 0
  alarm_name                = "${var.alert_level}-${var.opensearch_domain}-opensearch-master-jvm-pressure"
  comparison_operator       = "LessThanOrEqualToThreshold"
  evaluation_periods        = var.master_jvm_evaluation_periods
  metric_name               = "MasterJVMMemoryPressure"
  namespace                 = "AWS/ES"
  period                    = var.master_jvm_period
  statistic                 = "Maximum"
  threshold                 = var.master_jvm_threshold
  alarm_description         = "The ${var.alert_level} alarm to monitor the ${var.opensearch_domain} AWS Opensearch cluster cpu utilization is not consistently above ${var.master_jvm_threshold}%"
  alarm_actions             = var.alarm_actions
  dimensions = {
    DomainName = var.opensearch_domain
    ClientId   = data.aws_caller_identity.current.account_id
  }
}

resource "aws_cloudwatch_metric_alarm" "storage_space" {
  count                     = var.opensearch_alarms_required ? 1 : 0
  alarm_name                = "${var.alert_level}-${var.opensearch_domain}-opensearch-storage-available"
  comparison_operator       = "LessThanOrEqualToThreshold"
  evaluation_periods        = "2"
  metric_name               = "FreeStorageSpace"
  namespace                 = "AWS/ES"
  period                    = "60"
  statistic                 = "Average"
  threshold                 = var.storage_percentage*lookup(local.instance_types, var.opensearch_instance, "i3.large.elasticsearch")
  alarm_description         = "The ${var.alert_level} alarm to monitor the ${var.opensearch_domain} AWS Opensearch cluster storage space available"
  alarm_actions             = var.alarm_actions
  dimensions = {
    DomainName = var.opensearch_domain
    ClientId   = data.aws_caller_identity.current.account_id
  }
}

resource "aws_cloudwatch_metric_alarm" "unreachable_nodes" {
  count                     = var.opensearch_alarms_required ? 1 : 0
  alarm_name                = "${var.alert_level}-${var.opensearch_domain}-opensearch-nodes-unreachable"
  comparison_operator       = "LessThanOrEqualToThreshold"
  evaluation_periods        = var.unreachable_node_evaluation_periods
  metric_name               = "Nodes"
  namespace                 = "AWS/ES"
  period                    = var.unreachable_node_period
  statistic                 = "Minimum"
  threshold                 = var.unreachable_node_threshold
  alarm_description         = "The ${var.alert_level} alarm to monitor if the ${var.opensearch_domain} AWS Opensearch cluster nodes become unreachable."
  alarm_actions             = var.alarm_actions
  dimensions = {
    DomainName = var.opensearch_domain
    ClientId   = data.aws_caller_identity.current.account_id
  }
}

resource "aws_cloudwatch_metric_alarm" "blocking_writes" {
  count                     = var.opensearch_alarms_required ? 1 : 0
  alarm_name                = "${var.alert_level}-${var.opensearch_domain}-opensearch-index-writes-blocked"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "1"
  metric_name               = "ClusterIndexWritesBlocked"
  namespace                 = "AWS/ES"
  period                    = "300"
  statistic                 = "Maximum"
  threshold                 = "1"
  alarm_description         = "The ${var.alert_level} alarm to monitor if the ${var.opensearch_domain} AWS Opensearch automated snapshot fails."
  alarm_actions             = var.alarm_actions
  dimensions = {
    DomainName = var.opensearch_domain
    ClientId   = data.aws_caller_identity.current.account_id
  }
}

resource "aws_cloudwatch_metric_alarm" "automated_snapshot" {
  count                     = var.opensearch_alarms_required ? 1 : 0
  alarm_name                = "${var.alert_level}-${var.opensearch_domain}-opensearch-automated-snapshot"
  comparison_operator       = "LessThanOrEqualToThreshold"
  evaluation_periods        = "1"
  metric_name               = "AutomatedSnapshotFailure"
  namespace                 = "AWS/ES"
  period                    = "60"
  statistic                 = "Maximum"
  threshold                 = "1"
  alarm_description         = "The ${var.alert_level} alarm to monitor if the ${var.opensearch_domain} AWS Opensearch automated snapshot fails."
  alarm_actions             = var.alarm_actions
  dimensions = {
    DomainName = var.opensearch_domain
    ClientId   = data.aws_caller_identity.current.account_id
  }
}
