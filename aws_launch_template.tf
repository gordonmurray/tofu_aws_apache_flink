
# Flink task managers
resource "aws_launch_template" "flink_taskmanagers_spot" {
  name                                 = "flink-taskmanager-template-spot"
  disable_api_stop                     = false
  disable_api_termination              = false
  ebs_optimized                        = true
  image_id                             = "ami-00be39d121a542573" //  flink AMI, created https://github.com/Teamwork/ops-terraform-amis/pull/35
  instance_initiated_shutdown_behavior = "terminate"
  instance_type                        = var.flink_taskmanager_instance_type
  key_name                             = aws_key_pair.flink.key_name
  vpc_security_group_ids               = [aws_security_group.flink.id]

  instance_market_options {
    market_type = "spot"
  }

  iam_instance_profile {
    arn = aws_iam_instance_profile.ec2_s3_write_profile.arn
  }

  block_device_mappings {
    device_name = "/dev/sda1"

    ebs {
      volume_size = 50
    }
  }

  metadata_options {
    http_tokens   = "required"
    http_endpoint = "enabled"
  }

  monitoring {
    enabled = true
  }

  placement {
    availability_zone = "us-east-1a"
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "Apache Flink v1.17.2 Task Manager"
    }
  }
}