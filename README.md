# acp-tf-aws-opensearch-alerting
Terraform module to provision recommended cloudwatch alarms for logging components and integrations with on call channels. 

## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_archive"></a> [archive](#provider\_archive) | n/a |
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_metric_alarm.automated_snapshot](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.blocking_writes](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.cluster_red](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.cluster_yellow](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.cpu_utilization_alert](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.jvm_pressure](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.kinesis_get_iterator_age](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.kinesis_read_throughput](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.kinesis_write_throughput](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.master_cpu_utilization](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.master_jvm_pressure](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.storage_space](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.unreachable_nodes](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_iam_role.lambda_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_lambda_function.slack_lambda](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function) | resource |
| [aws_lambda_permission.lambda_sns](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_permission) | resource |
| [aws_sns_topic.email](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic) | resource |
| [aws_sns_topic.opsgenie](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic) | resource |
| [aws_sns_topic.slack](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic) | resource |
| [aws_sns_topic_subscription.email](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic_subscription) | resource |
| [aws_sns_topic_subscription.opsgenie](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic_subscription) | resource |
| [aws_sns_topic_subscription.slack](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic_subscription) | resource |
| [archive_file.file](https://registry.terraform.io/providers/hashicorp/archive/latest/docs/data-sources/file) | data source |
| [aws_iam_policy_document.lambda_assume_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.lambda_kms_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cpu_utilization_evaluation_periods"></a> [cpu\_utilization\_evaluation\_periods](#input\_cpu\_utilization\_evaluation\_periods) | Number of periods to compare against the opensearch cluster cpu utilization threshold. | `string` | `"3"` | no |
| <a name="input_cpu_utilization_period"></a> [cpu\_utilization\_period](#input\_cpu\_utilization\_period) | Period that the statistic is applied against the opensearch cluster cpu utilization threshold. | `string` | `"900"` | no |
| <a name="input_cpu_utilization_threshold"></a> [cpu\_utilization\_threshold](#input\_cpu\_utilization\_threshold) | The opensearch cluster cpu utilization threshold. | `string` | `"80"` | no |
| <a name="input_email_address"></a> [email\_address](#input\_email\_address) | The email address to alert when a cloudwatch alarm is triggered. | `string` | `"test@test.com"` | no |
| <a name="input_get_iterator_evaluation_periods"></a> [get\_iterator\_evaluation\_periods](#input\_get\_iterator\_evaluation\_periods) | Number of periods to compare against the get iterator age threshold. | `string` | `"2"` | no |
| <a name="input_get_iterator_period"></a> [get\_iterator\_period](#input\_get\_iterator\_period) | Period that the statistic is applied against the get iterator age metric. | `string` | `"300"` | no |
| <a name="input_get_iterator_threshold"></a> [get\_iterator\_threshold](#input\_get\_iterator\_threshold) | Threshold for the get iterator age in milliseconds. | `string` | `"1800000"` | no |
| <a name="input_jvm_evaluation_periods"></a> [jvm\_evaluation\_periods](#input\_jvm\_evaluation\_periods) | Number of periods to compare against the jvm threshold. | `string` | `"3"` | no |
| <a name="input_jvm_period"></a> [jvm\_period](#input\_jvm\_period) | Period that the statistic is applied against the jvm threshold. | `string` | `"300"` | no |
| <a name="input_jvm_threshold"></a> [jvm\_threshold](#input\_jvm\_threshold) | The opensearch cluster jvm pressure threshold. | `string` | `"80"` | no |
| <a name="input_kinesis_alarms_required"></a> [kinesis\_alarms\_required](#input\_kinesis\_alarms\_required) | Boolean to determine if kinesis alarms are required. | `bool` | `false` | no |
| <a name="input_kinesis_stream_name"></a> [kinesis\_stream\_name](#input\_kinesis\_stream\_name) | Name of the kinesis stream to monitor. | `string` | `"acp-log-stream"` | no |
| <a name="input_lambda_handler"></a> [lambda\_handler](#input\_lambda\_handler) | The method used to execute your function. consists of file name and function name. | `string` | `"slack_alert.lambda_handler"` | no |
| <a name="input_master_cpu_utilization_evaluation_periods"></a> [master\_cpu\_utilization\_evaluation\_periods](#input\_master\_cpu\_utilization\_evaluation\_periods) | Number of periods to compare against, the master cpu utilization threshold. | `string` | `"3"` | no |
| <a name="input_master_cpu_utilization_period"></a> [master\_cpu\_utilization\_period](#input\_master\_cpu\_utilization\_period) | Period that the statistic is applied, against the dedicated master cpu utilization threshold. | `string` | `"900"` | no |
| <a name="input_master_cpu_utilization_threshold"></a> [master\_cpu\_utilization\_threshold](#input\_master\_cpu\_utilization\_threshold) | The opensearch cluster dedicated master cpu utilization threshold. | `string` | `"50"` | no |
| <a name="input_master_jvm_evaluation_periods"></a> [master\_jvm\_evaluation\_periods](#input\_master\_jvm\_evaluation\_periods) | Number of periods to compare against, the master jvm threshold. | `string` | `"3"` | no |
| <a name="input_master_jvm_period"></a> [master\_jvm\_period](#input\_master\_jvm\_period) | Period that the statistic is applied, against the dedicated master jvm threshold. | `string` | `"900"` | no |
| <a name="input_master_jvm_threshold"></a> [master\_jvm\_threshold](#input\_master\_jvm\_threshold) | The opensearch cluster dedicated master jvm pressure threshold. | `string` | `"80"` | no |
| <a name="input_opensearch_alarms_required"></a> [opensearch\_alarms\_required](#input\_opensearch\_alarms\_required) | Boolean to determine if opensearch cloudwatch alarms are required. | `bool` | `false` | no |
| <a name="input_opensearch_domain"></a> [opensearch\_domain](#input\_opensearch\_domain) | The opensearch domain that these alarms are required for. | `string` | `""` | no |
| <a name="input_opensearch_instance"></a> [opensearch\_instance](#input\_opensearch\_instance) | The opensearch instance type, used for determining the threshold for the storage alarm. | `string` | `""` | no |
| <a name="input_opsgenie_url"></a> [opsgenie\_url](#input\_opsgenie\_url) | The opsgenie url endpoint for the sns topic subscription. | `string` | `""` | no |
| <a name="input_read_throughput_evaluation_periods"></a> [read\_throughput\_evaluation\_periods](#input\_read\_throughput\_evaluation\_periods) | Number of periods to compare against the read throughput threshold. | `string` | `"3"` | no |
| <a name="input_read_throughput_period"></a> [read\_throughput\_period](#input\_read\_throughput\_period) | Period that the statistic is applied against the read throughput metric. | `string` | `"300"` | no |
| <a name="input_read_throughput_threshold"></a> [read\_throughput\_threshold](#input\_read\_throughput\_threshold) | The read throughput threshold for the statistic to be compared against. | `string` | `"0"` | no |
| <a name="input_runtime"></a> [runtime](#input\_runtime) | The runtime engine of the lambda function. | `string` | `"python3.8"` | no |
| <a name="input_slack_channel"></a> [slack\_channel](#input\_slack\_channel) | The slack channel to set as an environment variable within the lambda function. | `string` | `""` | no |
| <a name="input_slack_url"></a> [slack\_url](#input\_slack\_url) | The slack URL to set as an environment variable within the lambda function. | `string` | `""` | no |
| <a name="input_storage_threshold"></a> [storage\_threshold](#input\_storage\_threshold) | The opensearch cluster storage available threshold. | `string` | `"20480"` | no |
| <a name="input_timeout"></a> [timeout](#input\_timeout) | the lambda functions timeout in seconds | `string` | `"60"` | no |
| <a name="input_unreachable_node_evaluation_periods"></a> [unreachable\_node\_evaluation\_periods](#input\_unreachable\_node\_evaluation\_periods) | Number of periods to compare against, the master jvm threshold. | `string` | `"1"` | no |
| <a name="input_unreachable_node_period"></a> [unreachable\_node\_period](#input\_unreachable\_node\_period) | Period that the statistic is applied, against the opensearch cluster unreachable node threshold. | `string` | `"86400"` | no |
| <a name="input_unreachable_node_threshold"></a> [unreachable\_node\_threshold](#input\_unreachable\_node\_threshold) | The opensearch cluster unreachable node threshold. | `string` | `"3"` | no |
| <a name="input_write_throughput_evaluation_periods"></a> [write\_throughput\_evaluation\_periods](#input\_write\_throughput\_evaluation\_periods) | Number of periods to compare against the write throughput threshold. | `string` | `"3"` | no |
| <a name="input_write_throughput_period"></a> [write\_throughput\_period](#input\_write\_throughput\_period) | Period that the statistic is applied against the write throughput metric. | `string` | `"300"` | no |
| <a name="input_write_throughput_threshold"></a> [write\_throughput\_threshold](#input\_write\_throughput\_threshold) | The write throughput threshold for the statistic to be compared against. | `string` | `"0"` | no |

## Outputs

No outputs.