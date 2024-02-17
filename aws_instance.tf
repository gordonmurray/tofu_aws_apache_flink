resource "aws_instance" "flink_job_managers" {
  ami                     = data.aws_ami.flink_ami.id
  instance_type           = var.flink_jobmanager_instance_type
  count                   = var.flink_jobmanager_instance_count
  key_name                = aws_key_pair.flink.key_name
  vpc_security_group_ids  = [aws_security_group.flink_security_group.id]
  disable_api_termination = true
  subnet_id               = element(var.subnets, count.index)
  iam_instance_profile    = aws_iam_instance_profile.ec2_s3_write_profile.id
  tags = {
    Name   = "Apache Flink v1.17.2 Job Manager"
    Source = "https://github.com/gordonmurray/tofu_aws_apache_flink"
  }

  user_data = base64encode(<<-EOF
    #!/bin/bash

    # Wait for the system to start up fully
    sleep 30

    # Get the IP address of the instance
    TOKEN=`curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600"`
    PUBLIC_IP=$(curl -H "X-aws-ec2-metadata-token: $TOKEN" http://169.254.169.254/latest/meta-data/public-ipv4)
    sed -i "s/ACTUAL_IP_ADDRESS/$PUBLIC_IP/g" /home/ubuntu/flink/conf/flink-conf.yaml

    # start the flink job manager as the ubuntu user
    su - ubuntu -c '/home/ubuntu/flink/bin/start-cluster.sh'
    EOF
  )

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