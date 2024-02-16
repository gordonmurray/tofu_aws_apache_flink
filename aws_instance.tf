resource "aws_instance" "flink_job_managers" {
  ami                     = data.aws_ami.flink_ami.id
  instance_type           = var.flink_jobmanager_instance_type
  count                   = var.flink_jobmanager_instance_count
  key_name                = aws_key_pair.flink.key_name
  vpc_security_group_ids  = [aws_security_group.flink.id]
  disable_api_termination = true
  subnet_id               = element(var.subnets, count.index)
  iam_instance_profile    = aws_iam_instance_profile.ec2_s3_write_profile.id
  tags                    = var.tags

  root_block_device {
    delete_on_termination = true
    encrypted             = true
    volume_size           = "50"
    volume_type           = "gp3"
    tags                  = var.tags
  }

  metadata_options {
    http_tokens   = "required"
    http_endpoint = "enabled"
  }

}