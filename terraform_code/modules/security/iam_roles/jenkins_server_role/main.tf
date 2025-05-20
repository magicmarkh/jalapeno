resource "aws_iam_policy" "jenkins_policy" {
  name = "${var.team_name}-jenkins-policy"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      # S3 access to specific bucket
      {
        Sid    = "S3AccessToSpecificBucket",
        Effect = "Allow",
        Action = [
          "s3:ListBucket",
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject"
        ],
        Resource = [
          "${var.s3_bucket_arn}",
          "${var.s3_bucket_arn}/*"
        ]
      },
      # EC2 creation and management
      {
        Sid    = "EC2ManagementAccess",
        Effect = "Allow",
        Action = [
          "ec2:RunInstances",
          "ec2:TerminateInstances",
          "ec2:StartInstances",
          "ec2:StopInstances",
          "ec2:Describe*",
          "ec2:CreateTags",
          "ec2:DeleteTags",
          "iam:PassRole"  // Required if launching EC2 instances with IAM roles
        ],
        Resource = "*",
        Condition = {
          StringEquals = {
            "ec2:Vpc" = var.vpc_arn
          }
        }
      },
      # RDS instance creation
      {
        Sid    = "RDSManagementAccess",
        Effect = "Allow",
        Action = [
          "rds:CreateDBInstance",
          "rds:DeleteDBInstance",
          "rds:StartDBInstance",
          "rds:StopDBInstance",
          "rds:Describe*",
          "rds:ModifyDBInstance",
          "rds:AddTagsToResource",
          "rds:RemoveTagsFromResource"
        ],
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role" "jenkins_role" {
  name = "${var.team_name}-jenkins-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = {
        Service = "ec2.amazonaws.com"
      },
      Action = "sts:AssumeRole"
    }]
  })

  tags = {
    Name  = "${var.team_name}-jenkins-role"
    Owner = var.asset_owner_name
  }
}

resource "aws_iam_role_policy_attachment" "attach_jenkins_policy_to_role" {
  role       = aws_iam_role.jenkins_role.name
  policy_arn = aws_iam_policy.jenkins_policy.arn
}
