resource "aws_security_group" "flink_security_group" {
  name        = "flink"
  description = "flink security group"
  vpc_id      = var.vpc_id
  tags        = var.tags
}