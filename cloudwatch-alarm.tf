resource "aws_cloudwatch_metric_alarm" "kinesis_get_records_success" {
  count               = var.kinesis_alarms_required ? 1 : 0
  alarm_name          = "${var.environment}-${var.kinesis_stream_name}-kinesis-get-record-success"
  comparison_operator = "LessThanOrEqualToThreshold"
  metric_name         = "GetRecords.Success"
  namespace           = "AWS/Kinesis"
  statistic           = "Average"
  evaluation_periods  = var.get_records_success_evaluation_periods
  period              = var.get_records_success_period
  threshold           = var.get_records_success_threshold
  alarm_description   = "GetRecords.Success has gone below the threshold value. This means some consumers of the stream are receiving errors or aren't request at all, this will cause a backlog in the Opensearch cluster. Environment: ${var.environment}"
  alarm_actions       = var.alarm_actions
  dimensions = {
    StreamName = var.kinesis_stream_name
  }
}

resource "aws_cloudwatch_metric_alarm" "kinesis_put_records_success" {
  count               = var.kinesis_alarms_required ? 1 : 0
  alarm_name          = "${var.environment}-${var.kinesis_stream_name}-kinesis-put-record-success"
  comparison_operator = "LessThanOrEqualToThreshold"
  metric_name         = "PutRecords.Success"
  namespace           = "AWS/Kinesis"
  statistic           = "Average"
  evaluation_periods  = var.put_records_success_evaluation_periods
  period              = var.put_records_success_period
  threshold           = var.put_records_success_threshold
  alarm_description   = "Produers to the stream are receiving an error or not pushing at all, if this is prolonged it will cause FluentD to go into a backoffloop and stop pushing to Kinesis. Environment: ${var.environment}"
  alarm_actions       = var.alarm_actions
  dimensions = {
    StreamName = var.kinesis_stream_name
  }
}

resource "aws_cloudwatch_metric_alarm" "kinesis_get_iterator_age" {
  count               = var.kinesis_alarms_required ? 1 : 0
  alarm_name          = "${var.environment}-${var.kinesis_stream_name}-kinesis-iterator-age"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = var.get_iterator_evaluation_periods
  metric_name         = "GetRecords.IteratorAgeMilliseconds"
  namespace           = "AWS/Kinesis"
  period              = var.get_iterator_period
  statistic           = "Average"
  threshold           = var.get_iterator_threshold
  alarm_description   = "The oldest record requested from Kinesis has reached the threshold value of ${var.get_iterator_threshold} milliseconds. This means there will be no logs in Opensearch younger than this time, this could mean that there is a large influx or logs - or if this metric keeps increasing Logstash has stopped ingesting. ${var.environment} environment"
  alarm_actions       = var.alarm_actions
  dimensions = {
    StreamName = var.kinesis_stream_name
  }
}

resource "aws_cloudwatch_metric_alarm" "kinesis_read_throughput" {
  count               = var.kinesis_alarms_required ? 1 : 0
  alarm_name          = "${var.environment}-${var.kinesis_stream_name}-kinesis-read-throughput"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = var.read_throughput_evaluation_periods
  metric_name         = "ReadProvisionedThroughputExceeded"
  namespace           = "AWS/Kinesis"
  period              = var.read_throughput_period
  statistic           = "Average"
  threshold           = var.read_throughput_threshold
  alarm_description   = "ReadProvisionedThroughputExceeded has been exceeded, meaning Logstash won't be able to pull the latest logs. In our setup this is a highly suspicous alarm."
  alarm_actions       = var.alarm_actions
  dimensions = {
    StreamName = var.kinesis_stream_name
  }
}

resource "aws_cloudwatch_metric_alarm" "kinesis_write_throughput" {
  count               = var.kinesis_alarms_required ? 1 : 0
  alarm_name          = "${var.environment}-${var.kinesis_stream_name}-kinesis-write-throughput"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = var.write_throughput_evaluation_periods
  metric_name         = "WriteProvisionedThroughputExceeded"
  namespace           = "AWS/Kinesis"
  period              = var.write_throughput_period
  statistic           = "Average"
  threshold           = var.write_throughput_threshold
  alarm_description   = "Kinesis stream has exceeded its write throughput and is blocking logs, if this is goes on for an extended amount of time or rejects a lot of logs it could cause FluentD to stop pushing to Kinesis and  could cause FluentD on Kubernetes nodes to stop and potential loss of logs. "
  alarm_actions       = var.alarm_actions
  dimensions = {
    StreamName = var.kinesis_stream_name
  }
}

resource "aws_cloudwatch_metric_alarm" "kinesis_put_record_throttled" {
  count               = var.kinesis_alarms_required ? 1 : 0
  alarm_name          = "${var.environment}-${var.kinesis_stream_name}-put-record-throttled"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = var.kinesis_put_records_throttled_evaluation_periods
  metric_name         = "PutRecords.ThrottledRecords"
  namespace           = "AWS/Kinesis"
  period              = var.kinesis_put_records_throttled_period
  statistic           = "Average"
  threshold           = var.kinesis_put_records_throttled_threshold
  alarm_description   = "Some Putrecords are being rejected by Kinesis, likely too many records to be ingested, or a transient error. If this is a high number it could cause FluentD to stop pushing logs to Kinesis."
  alarm_actions       = var.alarm_actions
  dimensions = {
    StreamName = var.kinesis_stream_name
  }
}

resource "aws_cloudwatch_metric_alarm" "cluster_yellow" {
  count               = var.opensearch_alarms_required ? 1 : 0
  alarm_name          = "warning-${var.opensearch_domain}-opensearch-cluster-yellow"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = var.cluster_yellow_evaluation_periods
  metric_name         = "ClusterStatus.yellow"
  namespace           = "AWS/ES"
  period              = var.cluster_yellow_period
  statistic           = "Maximum"
  threshold           = "1"
  alarm_description   = "The ${var.environment} environment warning alarm to monitor the AWS Opensearch cluster status is yellow for ${var.opensearch_domain}. This means atleast one of the indexes does not have a replica shard, if this is prolonged it is something that should be investigated."
  alarm_actions       = var.alarm_actions
  dimensions = {
    DomainName = var.opensearch_domain
    ClientId   = data.aws_caller_identity.current.account_id
  }
}

resource "aws_cloudwatch_metric_alarm" "cluster_red" {
  count               = var.opensearch_alarms_required ? 1 : 0
  alarm_name          = "warning-${var.opensearch_domain}-opensearch-cluster-red"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = var.cluster_red_evaluation_periods
  metric_name         = "ClusterStatus.red"
  namespace           = "AWS/ES"
  period              = var.cluster_red_period
  statistic           = "Maximum"
  threshold           = "1"
  alarm_description   = "The ${var.environment} environment warning alarm to monitor the AWS Opensearch cluster status is red for ${var.opensearch_domain}. This means at least one of the indexes doesn't have a primary replica, this could mean data loss of an index or an index is unable to schedule a primary shard which would stop writes."
  alarm_actions       = var.alarm_actions
  dimensions = {
    DomainName = var.opensearch_domain
    ClientId   = data.aws_caller_identity.current.account_id
  }
}

resource "aws_cloudwatch_metric_alarm" "critical_cluster_red" {
  count               = var.opensearch_alarms_required ? 1 : 0
  alarm_name          = "critical-${var.opensearch_domain}-opensearch-cluster-red"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = var.critical_cluster_red_evaluation_periods
  metric_name         = "ClusterStatus.red"
  namespace           = "AWS/ES"
  period              = var.critical_cluster_red_period
  statistic           = "Minimum"
  threshold           = "1"
  alarm_description   = "The ${var.environment} environment critical alarm to monitor the AWS Opensearch cluster status is red for ${var.opensearch_domain}. This means at least one of the indexes doesn't have a primary replica, this could mean data loss of an index or an index is unable to schedule a primary shard which would stop writes."
  alarm_actions       = var.critical_alarm_actions
  dimensions = {
    DomainName = var.opensearch_domain
    ClientId   = data.aws_caller_identity.current.account_id
  }
}

resource "aws_cloudwatch_metric_alarm" "cpu_utilization_alert" {
  count               = var.opensearch_alarms_required ? 1 : 0
  alarm_name          = "${var.environment}-${var.opensearch_domain}-opensearch-cpu-utlization"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = var.cpu_utilization_evaluation_periods
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ES"
  period              = var.cpu_utilization_period
  statistic           = "Maximum"
  threshold           = var.cpu_utilization_threshold
  alarm_description   = "AWS Opensearch cluster cpu utilization is consistently above ${var.cpu_utilization_threshold}% for The ${var.environment} environment for ${var.opensearch_domain} domain. If consistently being triggered it could mean that cluster needs to be scaled up or have different nodes."
  alarm_actions       = var.alarm_actions
  dimensions = {
    DomainName = var.opensearch_domain
    ClientId   = data.aws_caller_identity.current.account_id
  }
}

resource "aws_cloudwatch_metric_alarm" "jvm_pressure" {
  count               = var.opensearch_alarms_required ? 1 : 0
  alarm_name          = "${var.environment}-${var.opensearch_domain}-opensearch-jvm-pressure"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = var.jvm_evaluation_periods
  metric_name         = "JVMMemoryPressure"
  namespace           = "AWS/ES"
  period              = var.jvm_period
  statistic           = "Maximum"
  threshold           = var.jvm_threshold
  alarm_description   = "AWS Opensearch cluster jvm pressure is above ${var.jvm_threshold}% in ${var.environment} environment for domain ${var.opensearch_domain}"
  alarm_actions       = var.alarm_actions
  dimensions = {
    DomainName = var.opensearch_domain
    ClientId   = data.aws_caller_identity.current.account_id
  }
}

resource "aws_cloudwatch_metric_alarm" "master_cpu_utilization" {
  count               = var.opensearch_alarms_required ? 1 : 0
  alarm_name          = "${var.environment}-${var.opensearch_domain}-opensearch-master-cpu-utlization"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = var.master_cpu_utilization_evaluation_periods
  metric_name         = "MasterCPUUtilization"
  namespace           = "AWS/ES"
  period              = var.master_cpu_utilization_period
  statistic           = "Average"
  threshold           = var.master_cpu_utilization_threshold
  alarm_description   = "AWS Opensearch cluster master nodes cpu utilization is consistently above ${var.master_cpu_utilization_threshold}%. ${var.environment} environment on domain ${var.opensearch_domain}"
  alarm_actions       = var.alarm_actions
  dimensions = {
    DomainName = var.opensearch_domain
    ClientId   = data.aws_caller_identity.current.account_id
  }
}

resource "aws_cloudwatch_metric_alarm" "master_jvm_pressure" {
  count               = var.opensearch_alarms_required ? 1 : 0
  alarm_name          = "${var.environment}-${var.opensearch_domain}-opensearch-master-jvm-pressure"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = var.master_jvm_evaluation_periods
  metric_name         = "MasterJVMMemoryPressure"
  namespace           = "AWS/ES"
  period              = var.master_jvm_period
  statistic           = "Maximum"
  threshold           = var.master_jvm_threshold
  alarm_description   = "The ${var.environment} environment alarm to monitor the ${var.opensearch_domain} "
  alarm_actions       = var.alarm_actions
  dimensions = {
    DomainName = var.opensearch_domain
    ClientId   = data.aws_caller_identity.current.account_id
  }
}

resource "aws_cloudwatch_metric_alarm" "storage_space" {
  count               = var.opensearch_alarms_required ? 1 : 0
  alarm_name          = "${var.environment}-${var.opensearch_domain}-opensearch-storage-available"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "FreeStorageSpace"
  namespace           = "AWS/ES"
  period              = "60"
  statistic           = "Minimum"
  threshold           = var.storage_percentage * lookup(local.instance_types, var.opensearch_instance, "i3.large.elasticsearch")
  alarm_description   = "The ${var.environment} environment alarm to monitor the ${var.opensearch_domain} AWS Opensearch cluster storage space available"
  alarm_actions       = var.alarm_actions
  dimensions = {
    DomainName = var.opensearch_domain
    ClientId   = data.aws_caller_identity.current.account_id
  }
}

resource "aws_cloudwatch_metric_alarm" "unreachable_nodes" {
  count               = var.opensearch_alarms_required ? 1 : 0
  alarm_name          = "critical-${var.environment}-${var.opensearch_domain}-opensearch-nodes-unreachable"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = var.unreachable_node_evaluation_periods
  metric_name         = "Nodes"
  namespace           = "AWS/ES"
  period              = var.unreachable_node_period
  statistic           = "Minimum"
  threshold           = var.unreachable_node_threshold
  alarm_description   = "The ${var.environment} environment alarm to monitor if the ${var.opensearch_domain} AWS Opensearch cluster nodes become unreachable."
  alarm_actions       = var.critical_alarm_actions
  dimensions = {
    DomainName = var.opensearch_domain
    ClientId   = data.aws_caller_identity.current.account_id
  }
}

resource "aws_cloudwatch_metric_alarm" "blocking_writes" {
  count               = var.opensearch_alarms_required ? 1 : 0
  alarm_name          = "${var.environment}-${var.opensearch_domain}-opensearch-index-writes-blocked"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = var.blocking_writes_evaluation_periods
  metric_name         = "ClusterIndexWritesBlocked"
  namespace           = "AWS/ES"
  period              = var.blocking_writes_period
  statistic           = "Maximum"
  threshold           = "1"
  alarm_description   = "The ${var.environment} environment alarm to monitor if the ${var.opensearch_domain} AWS Opensearch is blocking incoming write requests. Some common factors include the following: FreeStorageSpace is too low or JVMMemoryPressure is too high. To alleviate this issue, consider adding more disk space or scaling your cluster."
  alarm_actions       = var.alarm_actions
  dimensions = {
    DomainName = var.opensearch_domain
    ClientId   = data.aws_caller_identity.current.account_id
  }
}

resource "aws_cloudwatch_metric_alarm" "critical_blocking_writes" {
  count               = var.opensearch_alarms_required ? 1 : 0
  alarm_name          = "critical-${var.environment}-${var.opensearch_domain}-opensearch-index-writes-blocked-critical"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = var.critical_blocking_writes_evaluation_periods
  metric_name         = "ClusterIndexWritesBlocked"
  namespace           = "AWS/ES"
  period              = var.critical_blocking_writes_period
  statistic           = "Maximum"
  threshold           = "1"
  alarm_description   = "The ${var.environment} environment alarm to monitor if the ${var.opensearch_domain} AWS Opensearch is blocking incoming write requests. Some common factors include the following: FreeStorageSpace is too low or JVMMemoryPressure is too high. To alleviate this issue, consider adding more disk space or scaling your cluster."
  alarm_actions       = var.critical_alarm_actions
  dimensions = {
    DomainName = var.opensearch_domain
    ClientId   = data.aws_caller_identity.current.account_id
  }
}

resource "aws_cloudwatch_metric_alarm" "automated_snapshot" {
  count               = var.opensearch_alarms_required ? 1 : 0
  alarm_name          = "${var.environment}-${var.opensearch_domain}-opensearch-automated-snapshot"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "AutomatedSnapshotFailure"
  namespace           = "AWS/ES"
  period              = "60"
  statistic           = "Maximum"
  threshold           = "1"
  alarm_description   = "The ${var.environment} environment alarm to monitor if the ${var.opensearch_domain} AWS Opensearch automated snapshot fails."
  alarm_actions       = var.alarm_actions
  dimensions = {
    DomainName = var.opensearch_domain
    ClientId   = data.aws_caller_identity.current.account_id
  }
}


resource "aws_cloudwatch_metric_alarm" "opensearch_KMSKeyError" {
  count               = var.opensearch_alarms_required ? 1 : 0
  alarm_name          = "critical-${var.environment}-${var.opensearch_domain}-opensearch-KMSKeyError"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "KMSKeyError"
  namespace           = "AWS/ES"
  period              = "60"
  statistic           = "Maximum"
  threshold           = "1"
  alarm_description   = "The ${var.environment} environment alarm to monitor if the ${var.opensearch_domain} AWS Opensearch KMSKeyError failure."
  alarm_actions       = var.critical_alarm_actions
  dimensions = {
    DomainName = var.opensearch_domain
    ClientId   = data.aws_caller_identity.current.account_id
  }
}

resource "aws_cloudwatch_metric_alarm" "opensearch_KMSKeyInaccessible" {
  count               = var.opensearch_alarms_required ? 1 : 0
  alarm_name          = "critical-${var.environment}-${var.opensearch_domain}-opensearch-KMSKeyInaccessible"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "KMSKeyInaccessible"
  namespace           = "AWS/ES"
  period              = "60"
  statistic           = "Maximum"
  threshold           = "1"
  alarm_description   = "The ${var.environment} environment alarm to monitor if the ${var.opensearch_domain} AWS Opensearch KMSKeyInaccessible failure."
  alarm_actions       = var.critical_alarm_actions
  dimensions = {
    DomainName = var.opensearch_domain
    ClientId   = data.aws_caller_identity.current.account_id
  }
}