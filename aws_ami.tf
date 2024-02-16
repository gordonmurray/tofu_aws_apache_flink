data "aws_ami" "flink_ami" {
  most_recent = true

  filter {
    name   = "name"
    values = ["flink"]
  }
  owners = [var.aws_account_id]
}