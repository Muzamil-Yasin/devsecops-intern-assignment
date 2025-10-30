# ===========================================================
# Terraform Variables for CI/CD Pipeline
# ===========================================================

# --------------------------
# GitHub Configuration
# --------------------------
variable "github_oauth_token" {
  description = "GitHub Personal Access Token for OAuth authentication"
  type        = string
  sensitive   = true
}

variable "repository_name" {
  description = "GitHub repository name"
  default     = "devsecops-intern-assignment"

}

variable "branch_name" {
  description = "GitHub branch to build from"
  default     = "main"
}

# --------------------------
# CodePipeline Configuration
# --------------------------
variable "pipeline_name" {
  description = "Name of the CodePipeline"
  default     = "CI-CD-Application-Pipeline"
}

# --------------------------
# CodeBuild Configuration
# --------------------------
variable "codebuild_project_name" {
  description = "Name of the CodeBuild project"
  default     = "CI-CD-Application-Build"
}

