variable "environment" {
  description = "The environment it is in, which is suffixed to the alarm"
}

variable "alarm_actions" {
  description = "The actions for the alarm to take when in an alarm state"
  default     = []
}

variable "critical_alarm_actions" {
  description = "On call actions for the alarm to take when in an alarm state"
  default     = []
}

# Kinesis
variable "kinesis_alarms_required" {
  description = "Boolean to determine if kinesis alarms are required."
  default     = false
}
variable "kinesis_stream_name" {
  description = "Name of the kinesis stream to monitor."
  default     = "acp-log-stream"
}

variable "get_iterator_period" {
  description = "Period that the statistic is applied against the get iterator age metric."
  default     = "600"
}

variable "get_iterator_evaluation_periods" {
  description = "Number of periods to compare against the get iterator age threshold."
  default     = "3"
}

variable "get_iterator_threshold" {
  description = "Threshold for the get iterator age in milliseconds."
  default     = "1800000"
}

variable "read_throughput_evaluation_periods" {
  description = "Number of periods to compare against the read throughput threshold."
  default     = "3"
}

variable "read_throughput_period" {
  description = "Period that the statistic is applied against the read throughput metric."
  default     = "300"
}
variable "read_throughput_threshold" {
  description = "The read throughput threshold for the statistic to be compared against."
  default     = "0.5"
}
variable "write_throughput_evaluation_periods" {
  description = "Number of periods to compare against the write throughput threshold."
  default     = "3"
}
variable "write_throughput_period" {
  description = "Period that the statistic is applied against the write throughput metric."
  default     = "300"
}
variable "write_throughput_threshold" {
  description = "The write throughput threshold for the statistic to be compared against."
  default     = "100"
}

variable "kinesis_put_records_evaluation_periods" {
  description = "Number of periods to compare against the PutRecords.Success threshold."
  default     = "3"
}
variable "kinesis_put_records_period" {
  description = "Period that the statistic is applied against the PutRecords.Success metric."
  default     = "300"
}
variable "kinesis_put_records_threshold" {
  description = "The PutRecords.Success threshold for the statistic to be compared against."
  default     = "100"
}

# Opensearch
variable "opensearch_alarms_required" {
  description = "Boolean to determine if opensearch cloudwatch alarms are required."
  default     = false
}

variable "opensearch_domain" {
  description = "The opensearch domain that these alarms are required for."
  default     = ""
}

variable "opensearch_instance" {
  description = "The opensearch instance type, used for determining the threshold for the storage alarm."
  default     = ""
}

variable "cluster_yellow_evaluation_periods" {
  description = "Number of periods to compare against the threshold"
  default     = "6"
}

variable "cluster_yellow_period" {
  description = "Period size for statistic to applied against"
  default     = "300"
}

variable "cluster_red_evaluation_periods" {
  description = "Number of periods to compare against the threshold"
  default     = "6"
}

variable "cluster_red_period" {
  description = "Period size for statistic to applied against"
  default     = "300"
}

variable "critical_cluster_red_evaluation_periods" {
  description = "Number of periods to compare against the threshold"
  default     = "12"
}

variable "critical_cluster_red_period" {
  description = "Period size for statistic to applied against"
  default     = "300"
}

variable "critical_cluster_red_evaluation_periods" {
  description = "Number of periods to compare against the threshold"
  default     = "12"
}

variable "critical_cluster_red_period" {
  description = "Period size for statistic to applied against"
  default     = "300"
}

variable "cpu_utilization_evaluation_periods" {
  description = "Number of periods to compare against the opensearch cluster cpu utilization threshold."
  default     = "3"

}
variable "cpu_utilization_period" {
  description = "Period that the statistic is applied against the opensearch cluster cpu utilization threshold."
  default     = "900"
}

variable "cpu_utilization_threshold" {
  description = "The opensearch cluster cpu utilization threshold."
  default     = "80"
}

variable "jvm_threshold" {
  description = "The opensearch cluster jvm pressure threshold."
  default     = "85"
}

variable "jvm_evaluation_periods" {
  description = "Number of periods to compare against the jvm threshold."
  default     = "3"
}

variable "jvm_period" {
  description = "Period that the statistic is applied against the jvm threshold."
  default     = "900"
}

variable "master_cpu_utilization_evaluation_periods" {
  description = "Number of periods to compare against, the master cpu utilization threshold."
  default     = "3"
}

variable "master_cpu_utilization_period" {
  description = "Period that the statistic is applied, against the dedicated master cpu utilization threshold."
  default     = "900"
}

variable "master_cpu_utilization_threshold" {
  description = "The opensearch cluster dedicated master cpu utilization threshold."
  default     = "50"
}

variable "master_jvm_threshold" {
  description = "The opensearch cluster dedicated master jvm pressure threshold."
  default     = "80"
}

variable "master_jvm_evaluation_periods" {
  description = "Number of periods to compare against, the master jvm threshold."
  default     = "3"
}

variable "master_jvm_period" {
  description = "Period that the statistic is applied, against the dedicated master jvm threshold."
  default     = "900"
}

variable "unreachable_node_evaluation_periods" {
  description = "Number of periods to compare against, the master jvm threshold."
  default     = "1"
}

variable "unreachable_node_period" {
  description = "Period that the statistic is applied, against the opensearch cluster unreachable node threshold."
  default     = "86400"
}

variable "unreachable_node_threshold" {
  description = "The opensearch cluster unreachable node threshold."
  default     = "3"
}

variable "blocking_writes_evaluation_periods" {
  description = "Number of periods to compare against, the master jvm threshold."
  default     = "15"
}

variable "blocking_writes_period" {
  description = "Period that the statistic is applied, against the opensearch cluster unreachable node threshold."
  default     = "60"
}

variable "critical_blocking_writes_evaluation_periods" {
  description = "Number of periods to compare against."
  default     = "30"
}

variable "critical_blocking_writes_period" {
  description = "Period that the statistic is applied."
  default     = "60"
}

variable "storage_percentage" {
  description = "The value used to workout the percentage of the threshold."
  default     = "0.1"
}

variable "get_records_success_evaluation_periods" {
  description = "Number of periods to compare against the get records success threshold."
  default     = "2"
}

variable "get_records_success_period" {
  description = "Period that the statistic is applied against the get records success."
  default     = "300"
}

variable "get_records_success_threshold" {
  description = "Threshold for the get records success "
  default     = "0.5"
}

variable "put_records_success_evaluation_periods" {
  description = "Number of periods to compare against the put records success threshold."
  default     = "2"
}

variable "put_records_success_period" {
  description = "Period that the statistic is applied against the put records success."
  default     = "300"
}

variable "put_records_success_threshold" {
  description = "Threshold for the put records success"
  default     = "0.5"
}
