
resource "aws_launch_template" "flink_taskmanagers_spot_1" {
  name                                 = "flink-taskmanager-template-spot-1"
  disable_api_stop                     = false
  disable_api_termination              = false
  ebs_optimized                        = true
  image_id                             = data.aws_ami.flink_ami.id
  instance_initiated_shutdown_behavior = "terminate"
  instance_type                        = var.flink_taskmanager_instance_type_1
  key_name                             = aws_key_pair.flink.key_name
  vpc_security_group_ids               = [aws_security_group.flink_security_group.id]

  user_data = base64encode(<<-EOF
    #!/bin/bash

    # Wait for the system to start up fully
    sleep 30

    # Get the IP address of the instance
    TOKEN=`curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600"`
    PUBLIC_IP=$(curl -H "X-aws-ec2-metadata-token: $TOKEN" http://169.254.169.254/latest/meta-data/public-ipv4)
    sed -i "s/ACTUAL_IP_ADDRESS/$PUBLIC_IP/g" /home/ubuntu/flink/conf/flink-conf.yaml

    /home/ubuntu/flink/bin/taskmanager.sh start
    EOF
  )

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
    availability_zone = "${var.aws_region}a"
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "Apache Flink v1.17.2 Task Manager"
    }
  }
}

resource "aws_launch_template" "flink_taskmanagers_spot_2" {
  name                                 = "flink-taskmanager-template-spot-2"
  disable_api_stop                     = false
  disable_api_termination              = false
  ebs_optimized                        = true
  image_id                             = data.aws_ami.flink_ami.id
  instance_initiated_shutdown_behavior = "terminate"
  instance_type                        = var.flink_taskmanager_instance_type_2
  key_name                             = aws_key_pair.flink.key_name
  vpc_security_group_ids               = [aws_security_group.flink_security_group.id]

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
    availability_zone = "${var.aws_region}a"
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "Apache Flink v1.17.2 Task Manager"
    }
  }
}