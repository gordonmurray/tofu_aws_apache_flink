resource "aws_iam_policy" "s3_write" {
  name        = "s3_write_policy"
  description = "Policy for writing to a specific S3 bucket"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "s3:*"
        ],
        Resource = [
          "arn:aws:s3:::${var.s3_bucket}/*",
          "arn:aws:s3:::${var.s3_bucket}"
        ]
      }
    ]
  })
}