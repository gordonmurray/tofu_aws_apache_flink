variable "aws_account_id" {
  type = string
}

variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "vpc_id" {
  type = string
}

variable "subnets" {
  type = list(string)
}

variable "s3_bucket" {
  type = string
}

variable "tags" {
  type = map(string)
  default = {
    "Source" = "https://github.com/gordonmurray/tofu_aws_apache_flink"
  }
}

variable "flink_jobmanager_instance_type" {
  type    = string
  default = "m5.large"
}

variable "flink_taskmanager_instance_type" {
  type    = string
  default = "m5.large"
}

variable "flink_jobmanager_instance_count" {
  type    = number
  default = 1
}

variable "task_manager_slots" {
  type    = number
  default = 4
}

variable "jobmanager_memory_size" {
  type    = number
  default = 4096
}

variable "kafka_brokers" {
  type    = string
  default = ""
}