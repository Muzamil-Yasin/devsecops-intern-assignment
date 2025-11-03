resource "aws_ecr_repository" "app_repo" {
  name                 = "devsecops-intern-assignment"
  image_tag_mutability = "MUTABLE"

  tags = {
    Name        = "DevSecOpsApp"
    Environment = "Development"
    ManagedBy   = "Terraform"
  }
}
