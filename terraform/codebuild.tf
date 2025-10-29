# ===========================================================
# CodeBuild Project Configuration
# Builds and pushes Docker images from GitHub


resource "aws_codebuild_project" "cicd_build_project" {
  name         = "CI-CD-Application-Build"
  description  = "CodeBuild project for building and pushing Docker images from GitHub"
  service_role = aws_iam_role.codebuild_service_role.arn

  artifacts {
    type = "NO_ARTIFACTS"
  }

  environment {
    compute_type    = "BUILD_GENERAL1_SMALL"
    image           = "aws/codebuild/standard:7.0"
    type            = "LINUX_CONTAINER"
    privileged_mode = true # Required for Docker builds
  }

  source {
    type            = "GITHUB"
    location        = "https://github.com/Muzamil-Yasin/devsecops-intern-assignment.git"
    git_clone_depth = 1
    buildspec       = "buildspec.yml"
  }

  tags = {
    Name        = "CI-CD-Application-Build"
    Project     = "End-to-End CI/CD Pipeline"
    ManagedBy   = "Terraform"
    Environment = "Development"
    Owner       = "Muzamil Yasin"
    Department  = "DevSecOps"
  }
}
