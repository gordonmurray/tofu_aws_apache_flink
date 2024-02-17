# JobManager RPC Port
resource "aws_security_group_rule" "jobmanager_rpc" {
  type                     = "ingress"
  from_port                = 6123
  to_port                  = 6123
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.flink_security_group.id
  security_group_id        = aws_security_group.flink_security_group.id
}

# Blob Server Port
resource "aws_security_group_rule" "blob_server" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 65535
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.flink_security_group.id
  security_group_id        = aws_security_group.flink_security_group.id
}

# Queryable State Server Port
resource "aws_security_group_rule" "queryable_state_server" {
  type                     = "ingress"
  from_port                = 9067
  to_port                  = 9067
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.flink_security_group.id
  security_group_id        = aws_security_group.flink_security_group.id
}

# Flink UI Port
resource "aws_security_group_rule" "flink_ui" {
  type              = "ingress"
  from_port         = 8081
  to_port           = 8081
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.flink_security_group.id
}

# Data Transfer Ports
resource "aws_security_group_rule" "data_transfer" {
  type                     = "ingress"
  from_port                = 1024  // Starting port for data transfer range
  to_port                  = 65535 // Ending port for data transfer range
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.flink_security_group.id
  security_group_id        = aws_security_group.flink_security_group.id
}

# Allow all outbound traffic
resource "aws_security_group_rule" "allow_all_outbound" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.flink_security_group.id
}
