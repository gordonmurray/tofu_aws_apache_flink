output "flink_job_managers_public_ip" {
  value       = "http://${aws_instance.flink_job_managers[0].public_ip}:8081"
  description = "Public IP address of the Flink job managers instance."
}