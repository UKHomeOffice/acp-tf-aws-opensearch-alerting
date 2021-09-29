
# Kinesis
variable "kinesis_alarms_required" {
    description = "Boolean to determine if kinesis alarms are required."
    default = false 
} 
variable "kinesis_stream_name" { 
    description = "Name of the kinesis stream to monitor."
    default = "acp-log-stream" 
}
variable "get_iterator_period" { 
    description = "Period that the statistic is applied against the get iterator age metric."
    default = "300" 
}

variable "get_iterator_evaluation_periods" { 
    description = "Number of periods to compare against the get iterator age threshold."
    default = "2" 
} 

variable "get_iterator_threshold" {
    description = "Threshold for the get iterator age in milliseconds."
    default = "1800000"
} 

variable "read_throughput_evaluation_periods" { 
    description = "Number of periods to compare against the read throughput threshold."
    default = "3" 
} 

variable "read_throughput_period" { 
    description = "Period that the statistic is applied against the read throughput metric."
    default = "300" 
} 
variable "read_throughput_threshold" { 
    description = "The read throughput threshold for the statistic to be compared against."
    default = "0" 
} 
variable "write_throughput_evaluation_periods" { 
    description = "Number of periods to compare against the write throughput threshold."
    default = "3" 
} 
variable "write_throughput_period" { 
    description = "Period that the statistic is applied against the write throughput metric."
    default = "300" 
} 
variable "write_throughput_threshold" { 
    description = "The write throughput threshold for the statistic to be compared against."
    default = "0" 
} 

# Opensearch
variable "opensearch_alarms_required" { 
    description = "Boolean to determine if opensearch cloudwatch alarms are required."   
    default = false 
} 

variable "opensearch_domain" { 
    description = "The opensearch domain that these alarms are required for."   
    default = "" 
} 

variable "opensearch_instance" { 
    description = "The opensearch instance type, used for determining the threshold for the storage alarm."   
    default = "" 
} 


variable "cpu_utilization_evaluation_periods" { 
    description = "Number of periods to compare against the opensearch cluster cpu utilization threshold."
    default = "3" 

} 
variable "cpu_utilization_period" { 
    description = "Period that the statistic is applied against the opensearch cluster cpu utilization threshold."
    default = "900" 
} 

variable "cpu_utilization_threshold" { 
    description = "The opensearch cluster cpu utilization threshold."
    default = "80" 
}

variable "jvm_threshold" {
    description = "The opensearch cluster jvm pressure threshold."
    default = "80" 
}

variable "jvm_evaluation_periods" { 
    description = "Number of periods to compare against the jvm threshold."
    default = "3" 
} 

variable "jvm_period" { 
    description = "Period that the statistic is applied against the jvm threshold."
    default = "300" 
} 

variable "master_cpu_utilization_evaluation_periods" { 
    description = "Number of periods to compare against, the master cpu utilization threshold."
    default = "3" 
} 

variable "master_cpu_utilization_period" { 
    description = "Period that the statistic is applied, against the dedicated master cpu utilization threshold."
    default = "900" 
} 

variable "master_cpu_utilization_threshold" { 
    description = "The opensearch cluster dedicated master cpu utilization threshold."
    default = "50" 
}

variable "master_jvm_threshold" { 
    description = "The opensearch cluster dedicated master jvm pressure threshold."
    default = "80" 
}

variable "master_jvm_evaluation_periods" { 
    description = "Number of periods to compare against, the master jvm threshold."
    default = "3" 
} 

variable "master_jvm_period" { 
    description = "Period that the statistic is applied, against the dedicated master jvm threshold."
    default = "900" 
} 

variable "unreachable_node_evaluation_periods" { 
    description = "Number of periods to compare against, the master jvm threshold."
    default = "1"  
}

variable "unreachable_node_period" { 
    description = "Period that the statistic is applied, against the opensearch cluster unreachable node threshold."
    default = "86400" 
}

variable "unreachable_node_threshold" { 
    description = "The opensearch cluster unreachable node threshold."
    default = "3" 
}

variable "storage_threshold" { 
    description = "The opensearch cluster storage available threshold."
    default = "20480" 
}

#SNS
variable "email_address" { 
    description = "The email address to alert when a cloudwatch alarm is triggered."
    default = "test@test.com"
}


variable "opsgenie_url" {
    description = "The opsgenie url endpoint for the sns topic subscription."
    default = ""
} 


#Lambda
variable "lambda_handler" { 
    description = "The method used to execute your function. consists of file name and function name."
    default = "slack_alert.lambda_handler"
} 

variable "runtime" { 
    description = "The runtime engine of the lambda function."
    default = "python3.8" 
} 

variable "slack_url" {
    description = "The slack URL to set as an environment variable within the lambda function."
    default = ""
} 
variable "slack_channel" {
    description = "The slack channel to set as an environment variable within the lambda function."
    default = ""
} 

variable "timeout" { 
    description = "the lambda functions timeout in seconds"
    default = "60" 
} 