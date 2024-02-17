output "flink_job_managers_public_ip" {
  value = aws_instance.flink_job_managers.public_ip
  description = "Public IP address of the Flink job managers instance."
}
