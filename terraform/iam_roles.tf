# ===========================================================
# IAM ROLES - CI/CD PIPELINE (CodeBuild, CodePipeline, CodeDeploy)
# ===========================================================

# -----------------------------
# IAM ROLE: CodeBuild
# -----------------------------
resource "aws_iam_role" "codebuild_service_role" {
  name = "CodeBuildServiceRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "codebuild.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = {
    Name        = "CodeBuildServiceRole"
    Project     = "End-to-End CI/CD Pipeline"
    ManagedBy   = "Terraform"
    Environment = "Development"
    Owner       = "Muzamil Yasin"
    Department  = "DevSecOps"
  }
}

# Attach managed policies for CodeBuild
resource "aws_iam_role_policy_attachment" "codebuild_attach_ecr_poweruser" {
  role       = aws_iam_role.codebuild_service_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPowerUser"
}

resource "aws_iam_role_policy_attachment" "codebuild_attach_developer_access" {
  role       = aws_iam_role.codebuild_service_role.name
  policy_arn = "arn:aws:iam::aws:policy/AWSCodeBuildDeveloperAccess"
}

# -----------------------------
# IAM ROLE: CodePipeline
# -----------------------------
resource "aws_iam_role" "codepipeline_service_role" {
  name = "CodePipelineServiceRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "codepipeline.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = {
    Name           = "CodePipelineServiceRole"
    Project        = "End-to-End CI/CD Pipeline"
    Environment    = "Development"
    ManagedBy      = "Terraform"
    Owner          = "Muzamil Yasin"
    Department     = "DevSecOps"
    Infrastructure = "Automated"
  }
}

# Attach managed policies for CodePipeline
resource "aws_iam_role_policy_attachment" "codepipeline_attach_full_access" {
  role       = aws_iam_role.codepipeline_service_role.name
  policy_arn = "arn:aws:iam::aws:policy/AWSCodePipelineFullAccess"
}

resource "aws_iam_role_policy_attachment" "codepipeline_attach_s3_access" {
  role       = aws_iam_role.codepipeline_service_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

resource "aws_iam_role_policy_attachment" "codepipeline_attach_codebuild_access" {
  role       = aws_iam_role.codepipeline_service_role.name
  policy_arn = "arn:aws:iam::aws:policy/AWSCodeBuildDeveloperAccess"
}

resource "aws_iam_role_policy_attachment" "codepipeline_attach_codedeploy_access" {
  role       = aws_iam_role.codepipeline_service_role.name
  policy_arn = "arn:aws:iam::aws:policy/AWSCodeDeployFullAccess"
}

# -----------------------------
# IAM ROLE: CodeDeploy
# -----------------------------
resource "aws_iam_role" "codedeploy_service_role" {
  name = "CodeDeployServiceRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "codedeploy.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = {
    Name        = "CodeDeployServiceRole"
    Project     = "End-to-End CI/CD Pipeline"
    ManagedBy   = "Terraform"
    Environment = "Development"
    Owner       = "Muzamil Yasin"
    Department  = "DevSecOps"
  }
}

resource "aws_iam_role_policy_attachment" "codedeploy_attach_service_role" {
  role       = aws_iam_role.codedeploy_service_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSCodeDeployRole"
}

# -----------------------------
# OUTPUTS
# -----------------------------
output "codebuild_role_arn" {
  value = aws_iam_role.codebuild_service_role.arn
}

output "codepipeline_role_arn" {
  value = aws_iam_role.codepipeline_service_role.arn
}

output "codedeploy_role_arn" {
  value = aws_iam_role.codedeploy_service_role.arn
}
