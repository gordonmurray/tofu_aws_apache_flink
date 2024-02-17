
resource "ansible_playbook" "playbook_jobmanagers" {
  playbook                = "playbook_jobmanager.yml"
  name                    = aws_instance.flink_job_managers[0].public_ip
  replayable              = true
  ignore_playbook_failure = true
  extra_vars = {
    ansible_hostname             = aws_instance.flink_job_managers[0].private_ip
    ansible_user                 = "ubuntu"
    ansible_ssh_private_key_file = aws_key_pair.flink.id
    ansible_python_interpreter   = "/usr/bin/python3"
  }
}
