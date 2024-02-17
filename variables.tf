variable "aws_account_id" {
  type = string
}

variable "aws_region" {
  type    = string
  default = "eu-west-1"
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
  default = "t4g.large"
}

variable "flink_taskmanager_instance_type_1" {
  type    = string
  default = "m7g.large"
}

variable "flink_taskmanager_instance_type_2" {
  type    = string
  default = "m7g.xlarge"
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