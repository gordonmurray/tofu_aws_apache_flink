resource "aws_security_group" "flink" {
  name        = "flink"
  description = "flink security group"
  vpc_id      = var.vpc_id
  tags        = var.tags
}