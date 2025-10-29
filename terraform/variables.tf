# ===========================================================
# Terraform Variables for CI/CD Pipeline
# ===========================================================

# GitHub Personal Access Token for OAuth authentication
variable "github_oauth_token" {
  description = "GitHub Personal Access Token for OAuth"
  type        = string
  sensitive   = true
}

# CodePipeline configuration
variable "pipeline_name" {
  description = "Name of the CodePipeline"
  default     = "end-to-end-cicd-pipeline"
}

# GitHub repository info
variable "repository_name" {
  description = "GitHub repository name"
  default     = "devsecops-intern-assignment"
}

variable "branch_name" {
  description = "GitHub branch to build from"
  default     = "main"
}

# CodeBuild project
variable "codebuild_project_name" {
  description = "Name of the CodeBuild project"
  default     = "ci-cd-application-build"
}

# ECS cluster and service (if needed in future)
variable "ecs_cluster_name" {
  description = "ECS cluster name for deployment"
  default     = "my-ecs-cluster"
}

variable "ecs_service_name" {
  description = "ECS service name for deployment"
  default     = "my-ecs-service"
}
