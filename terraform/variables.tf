# ------------------------
# VARIABLES
# ------------------------
variable "github_oauth_token" {}
variable "pipeline_name" { default = "my-cicd-pipeline" }
variable "repository_name" { default = "devsecops-intern-assignment" }
variable "branch_name" { default = "main" }
variable "codebuild_project_name" { default = "my-app-build" }
variable "ecs_cluster_name" { default = "my-ecs-cluster" }
variable "ecs_service_name" { default = "my-ecs-service" }