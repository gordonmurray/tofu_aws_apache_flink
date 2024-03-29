resource "aws_autoscaling_group" "flink_taskmanagers_spot_1" {
  name                      = "flink-taskmanager-asg-spot-1"
  desired_capacity          = 1
  max_size                  = 3
  min_size                  = 1
  vpc_zone_identifier       = var.subnets
  health_check_type         = "EC2"
  health_check_grace_period = 300
  force_delete              = true
  wait_for_capacity_timeout = "0"

  launch_template {
    id      = aws_launch_template.flink_taskmanagers_spot_1.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "Apache Flink v1.17.2 Task Manager"
    propagate_at_launch = true
  }

}

resource "aws_autoscaling_group" "flink_taskmanagers_spot_2" {
  name                      = "flink-taskmanager-asg-spot-2"
  desired_capacity          = 1
  max_size                  = 3
  min_size                  = 1
  vpc_zone_identifier       = var.subnets
  health_check_type         = "EC2"
  health_check_grace_period = 300
  force_delete              = true
  wait_for_capacity_timeout = "0"

  launch_template {
    id      = aws_launch_template.flink_taskmanagers_spot_2.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "Apache Flink v1.17.2 Task Manager"
    propagate_at_launch = true
  }

}