resource "aws_key_pair" "flink" {
  key_name   = "flink"
  public_key = file("~/.ssh/id_rsa.pub")
}