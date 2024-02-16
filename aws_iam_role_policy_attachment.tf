resource "aws_iam_role_policy_attachment" "s3_write_attach" {
  role       = aws_iam_role.ec2_s3_write_role.name
  policy_arn = aws_iam_policy.s3_write.arn
}

resource "aws_iam_role_policy_attachment" "ssm_managed_instance_core_attach" {
  role       = aws_iam_role.ec2_s3_write_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}