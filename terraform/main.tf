# ------------------------
# S3 bucket for pipeline artifacts
# ------------------------
resource "aws_s3_bucket" "artifact_bucket" {
  bucket = "${var.pipeline_name}-artifacts"
}

# ------------------------
# IAM Role for CodePipeline
# ------------------------
resource "aws_iam_role" "codepipeline_role" {
  name = "CodePipelineServiceRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "codepipeline.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "codepipeline_policy" {
  role       = aws_iam_role.codepipeline_role.name
  policy_arn = "arn:aws:iam::aws:policy/AWSCodePipelineFullAccess"
}

# ------------------------
# IAM Role for CodeBuild
# ------------------------
resource "aws_iam_role" "codebuild_role" {
  name = "CodeBuildServiceRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "codebuild.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "codebuild_policy" {
  role       = aws_iam_role.codebuild_role.name
  policy_arn = "arn:aws:iam::aws:policy/AWSCodeBuildDeveloperAccess"
}

# ------------------------
# CodeBuild Project
# ------------------------
resource "aws_codebuild_project" "app_build" {
  name          = var.codebuild_project_name
  service_role  = aws_iam_role.codebuild_role.arn
  build_timeout = 30

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
  compute_type    = "BUILD_GENERAL1_SMALL"
  image           = "aws/codebuild/standard:7.0"
  type            = "LINUX_CONTAINER"
  privileged_mode = true

  environment_variable {
    name  = "APP_NAME"
    value = "devsecops-intern-assignment"
  }

  environment_variable {
    name  = "ECR_REPO_URI"
    value = "471112595794.dkr.ecr.us-east-1.amazonaws.com/devsecops-intern-assignment"
  }

  environment_variable {
    name  = "AWS_REGION"
    value = "us-east-1"
  }
}

  source {
    type = "CODEPIPELINE"
  }
}

# ------------------------
# CodePipeline
# ------------------------
resource "aws_codepipeline" "app_pipeline" {
  name     = var.pipeline_name
  role_arn = aws_iam_role.codepipeline_role.arn

  artifact_store {
    type     = "S3"
    location = aws_s3_bucket.artifact_bucket.bucket
  }

  # Stage 1: Source
  stage {
    name = "Source"

    action {
      name             = "GitHubSource"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeStarSourceConnection"
      version          = "1"
      output_artifacts = ["source_output"]

      configuration = {
        ConnectionArn    = "arn:aws:codestar-connections:us-east-1:471112595794:connection/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
        FullRepositoryId = "Muzamil-Yasin/${var.repository_name}"
        BranchName       = var.branch_name
      }
    }
  }

  # Stage 2: Build
  stage {
    name = "Build"

    action {
      name             = "BuildAction"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      version          = "1"
      input_artifacts  = ["source_output"]
      output_artifacts = ["build_output"]

      configuration = {
        ProjectName = aws_codebuild_project.app_build.name
      }
    }
  }

  # Stage 3: Deploy
  stage {
    name = "Deploy"

    action {
      name            = "DeployAction"
      category        = "Deploy"
      owner           = "AWS"
      provider        = "ECS"
      version         = "1"
      input_artifacts = ["build_output"]

      configuration = {
        ClusterName = var.ecs_cluster_name
        ServiceName = var.ecs_service_name
      }
    }
  }
}
