resource "aws_codebuild_project" "cicd_build_project" {
  name         = "CI-CD-Application-Build"
  description  = "CodeBuild project for building and pushing Docker images from CodePipeline"
  service_role = aws_iam_role.codebuild_service_role.arn

  artifacts {
    type = "CODEPIPELINE"
  }

  source {
    type      = "CODEPIPELINE"
    buildspec = "buildspec.yml"
  }

  environment {
    compute_type    = "BUILD_GENERAL1_SMALL"
    image           = "aws/codebuild/standard:7.0"
    type            = "LINUX_CONTAINER"
    privileged_mode = true

    environment_variable {
      name  = "AWS_REGION"
      value = "us-east-1"
    }

    environment_variable {
      name  = "ECR_REPO_URI"
      value = aws_ecr_repository.app_repo.repository_url
    }

    environment_variable {
      name  = "APP_NAME"
      value = "devsecops-intern-assignment"
    }
  }

  timeout_in_minutes = 30

  tags = {
    Name        = "CI-CD-Application-Build"
    Project     = "End-to-End CI/CD Pipeline"
    ManagedBy   = "Terraform"
    Environment = "Development"
    Owner       = "Muzamil Yasin"
    Department  = "DevSecOps"
  }
}
