resource "aws_codebuild_project" "cicd_build_project" {
  name         = "CI-CD-Application-Build"
  description  = "CodeBuild project for building and pushing Docker images from CodePipeline"
  service_role = aws_iam_role.codebuild_service_role.arn

  #  Artifacts and source both must be CODEPIPELINE
  artifacts {
    type = "CODEPIPELINE"
  }

  source {
    type = "CODEPIPELINE"
    buildspec = "buildspec.yml"  # still points to your repo file
  }

  environment {
    compute_type    = "BUILD_GENERAL1_SMALL"
    image           = "aws/codebuild/standard:7.0"
    type            = "LINUX_CONTAINER"
    privileged_mode = true # needed for Docker-in-Docker

    environment_variable {
      name  = "AWS_REGION"
      value = "us-east-1"
    }

    environment_variable {
      name  = "ECR_REPO_URI"
      value = "052869605945.dkr.ecr.us-east-1.amazonaws.com/devsecops-intern-assignment"
    }

    environment_variable {
      name  = "APP_NAME"
      value = "my-node-app"
    }
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
