
resource "ansible_playbook" "playbook_jobmanagers" {
  playbook                = "playbook_jobmanagers.yml"
  name                    = aws_instance.flink_job_managers[0].private_ip
  replayable              = true
  ignore_playbook_failure = true
  extra_vars = {
    ansible_hostname             = aws_instance.flink_job_managers[0].private_ip
    ansible_user                 = "ubuntu"
    ansible_ssh_private_key_file = "${aws_key_pair.flink.id}.pem"
    ansible_python_interpreter   = "/usr/bin/python3"
    zookeeper_address            = aws_instance.flink_job_managers[0].private_ip # zookeeper is on the job manager
    s3_state_bucket              = var.s3_bucket                                 # s3 bucket for state
    brokers                      = var.kafka_brokers
    jobmanager_memory_size       = var.jobmanager_memory_size
    task_manager_slots           = var.task_manager_slots
  }
}