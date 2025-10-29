# ===========================================================
# S3 Bucket for CodePipeline Artifacts
# ===========================================================

resource "aws_s3_bucket" "artifact_bucket" {
  bucket        = "muzamil-project-artifacts-bucket"
  force_destroy = true # Allows Terraform to delete non-empty bucket

  tags = {
    Name        = "ProjectArtifacts"
    Project     = "End-to-End CI/CD Pipeline"
    ManagedBy   = "Terraform"
    Environment = "Development"
    Owner       = "Muzamil Yasin"
    Department  = "DevSecOps"
  }
}

# Output the bucket name for referencing in other resources
output "artifact_bucket_name" {
  value = aws_s3_bucket.artifact_bucket.bucket
}
