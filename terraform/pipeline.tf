# ===========================================================
# AWS CodePipeline Configuration
# End-to-End CI/CD Pipeline
# ===========================================================

resource "aws_codepipeline" "application_pipeline" {
  name     = var.pipeline_name
  role_arn = aws_iam_role.codepipeline_service_role.arn

  artifact_store {
    type     = "S3"
    location = aws_s3_bucket.artifact_bucket.bucket
  }

  # ------------------------
  # Stage 1: Source (GitHub)
  stage {
    name = "Source"

    action {
      name             = "FetchSourceFromGitHub"
      category         = "Source"
      owner            = "ThirdParty"
      provider         = "GitHub"
      version          = "1"
      output_artifacts = ["SourceOutput"]

      configuration = {
        Owner      = "Muzamil-Yasin"
        Repo       = var.repository_name
        Branch     = var.branch_name
        OAuthToken = var.github_oauth_token
      }
    }
  }

  # ------------------------
  # Stage 2: Build (CodeBuild)
  stage {
    name = "Build"

    action {
      name             = "BuildDockerImage"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["SourceOutput"]
      output_artifacts = ["BuildOutput"]
      version          = "1"

      configuration = {
        ProjectName = aws_codebuild_project.cicd_build_project.name
      }
    }
  }

  # ------------------------
  # Stage 3: Deploy (CodeDeploy)
  stage {
    name = "Deploy"

    action {
      name            = "DeployToEC2"
      category        = "Deploy"
      owner           = "AWS"
      provider        = "CodeDeploy"
      input_artifacts = ["BuildOutput"]
      version         = "1"

      configuration = {
        ApplicationName     = aws_codedeploy_app.ec2_application.name
        DeploymentGroupName = aws_codedeploy_deployment_group.ec2_deployment_group.deployment_group_name
      }
    }
  }

  # ------------------------
  # Pipeline Tags
  tags = {
    Name           = "End-to-End CI/CD Pipeline"
    Project        = "End-to-End CI/CD Pipeline"
    Environment    = "Development"
    ManagedBy      = "Terraform"
    Owner          = "Muzamil Yasin"
    Department     = "DevSecOps"
    Infrastructure = "Automated"
  }
}
