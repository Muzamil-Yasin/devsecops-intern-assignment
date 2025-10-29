# ===========================================================
# CodeDeploy Configuration for EC2 Deployment
# ===========================================================

# ---------- CodeDeploy Application ----------
resource "aws_codedeploy_app" "ec2_application" {
  name             = "EC2-Application-Deploy"
  compute_platform = "Server"

  tags = {
    Name        = "EC2ApplicationDeploy"
    Project     = "End-to-End CI/CD Pipeline"
    ManagedBy   = "Terraform"
    Environment = "Development"
    Owner       = "Muzamil Yasin"
    Department  = "DevSecOps"
  }
}

# ---------- CodeDeploy Deployment Group ----------
resource "aws_codedeploy_deployment_group" "ec2_deployment_group" {
  app_name              = aws_codedeploy_app.ec2_application.name
  deployment_group_name = "EC2-Deployment-Group"
  service_role_arn      = aws_iam_role.codedeploy_service_role.arn

  # Deployment configuration
  deployment_config_name = "CodeDeployDefault.AllAtOnce"

  # Deployment style (in-place)
  deployment_style {
    deployment_type   = "IN_PLACE"
    deployment_option = "WITHOUT_TRAFFIC_CONTROL"
  }

  # Target EC2 instances by tag
  ec2_tag_set {
    ec2_tag_filter {
      key   = "Environment"
      type  = "KEY_AND_VALUE"
      value = "Development"
    }
  }

  # Rollback settings
  auto_rollback_configuration {
    enabled = true
    events  = ["DEPLOYMENT_FAILURE"]
  }

  tags = {
    Name        = "EC2DeploymentGroup"
    Project     = "End-to-End CI/CD Pipeline"
    ManagedBy   = "Terraform"
    Environment = "Development"
    Owner       = "Muzamil Yasin"
    Department  = "DevSecOps"
  }
}
