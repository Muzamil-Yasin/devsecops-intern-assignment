# ===========================================================
# IAM Role for CodeBuild
# ===========================================================
resource "aws_iam_role" "codebuild_service_role" {
  name = "codebuild-service-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "codebuild.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}

# IAM Policy for CodeBuild permissions
resource "aws_iam_policy" "codebuild_policy" {
  name        = "codebuild-policy"
  description = "Policy for CodeBuild to access S3, ECR, CloudWatch Logs, and CodePipeline"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      # S3 permissions
      {
        Effect   = "Allow",
        Action   = ["s3:GetObject", "s3:PutObject", "s3:GetBucketLocation", "s3:ListBucket"],
        Resource = "*"
      },
      # ECR permissions
      {
        Effect = "Allow",
        Action = [
          "ecr:GetAuthorizationToken",
          "ecr:BatchCheckLayerAvailability",
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage",
          "ecr:CompleteLayerUpload",
          "ecr:UploadLayerPart",
          "ecr:InitiateLayerUpload",
          "ecr:PutImage"
        ],
        Resource = "*"
      },
      # CloudWatch Logs permissions
      {
        Effect = "Allow",
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        Resource = "*"
      },
      # CodePipeline permissions
      {
        Effect = "Allow",
        Action = [
          "codepipeline:PutJobSuccessResult",
          "codepipeline:PutJobFailureResult"
        ],
        Resource = "*"
      }
    ]
  })
}

# Attach the policy to the IAM role
resource "aws_iam_role_policy_attachment" "codebuild_policy_attach" {
  role       = aws_iam_role.codebuild_service_role.name
  policy_arn = aws_iam_policy.codebuild_policy.arn
}

# ===========================================================
# IAM Role for CodeDeploy
# ===========================================================
resource "aws_iam_role" "codedeploy_service_role" {
  name = "codedeploy-service-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = [
            "codedeploy.amazonaws.com",
            "ec2.amazonaws.com" # Added EC2 to allow instance profile to work
          ]
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}

# Attach the AWS-managed policy for CodeDeploy
resource "aws_iam_role_policy_attachment" "codedeploy_policy_attach" {
  role       = aws_iam_role.codedeploy_service_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSCodeDeployRole"
}

# Inline policy for ECR access (for CodeDeploy)
resource "aws_iam_role_policy" "codedeploy_ecr_policy" {
  name = "CodeDeployECRPolicy"
  role = aws_iam_role.codedeploy_service_role.name

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "ecr:GetAuthorizationToken",
          "ecr:BatchCheckLayerAvailability",
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage"
        ],
        Resource = "*"
      }
    ]
  })
}

# IAM Instance Profile for EC2
resource "aws_iam_instance_profile" "codedeploy_instance_profile" {
  name = "codedeploy-instance-profile"
  role = aws_iam_role.codedeploy_service_role.name
}

# ===========================================================
# IAM Role for CodePipeline
# ===========================================================
resource "aws_iam_role" "codepipeline_service_role" {
  name = "codepipeline-service-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "codepipeline.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = {
    Name        = "codepipeline-service-role"
    ManagedBy   = "Terraform"
    Environment = "Development"
  }
}

# Inline policy to allow S3 and CodeDeploy actions
resource "aws_iam_role_policy" "codepipeline_codedeploy_policy" {
  name = "CodePipelineCodeDeployPolicy"
  role = aws_iam_role.codepipeline_service_role.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid    = "S3AccessForArtifacts",
        Effect = "Allow",
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:GetBucketLocation",
          "s3:ListBucket"
        ],
        Resource = [
          "arn:aws:s3:::muzamil-project-artifacts-bucket-0e8a6353",
          "arn:aws:s3:::muzamil-project-artifacts-bucket-0e8a6353/*"
        ]
      },
      {
        Sid    = "AllowCodePipelineServices",
        Effect = "Allow",
        Action = [
          "codebuild:StartBuild",
          "codebuild:BatchGetBuilds",
          "codedeploy:CreateDeployment",
          "codedeploy:GetDeployment",
          "codedeploy:GetDeploymentConfig",
          "codedeploy:RegisterApplicationRevision",
          "codedeploy:GetApplicationRevision"
        ],
        Resource = "*"
      }
    ]
  })
}

# Attach AWS managed policy for general CodePipeline operations
resource "aws_iam_role_policy_attachment" "codepipeline_attach_managed_policy" {
  role       = aws_iam_role.codepipeline_service_role.name
  policy_arn = "arn:aws:iam::aws:policy/AWSCodePipeline_FullAccess"
}
