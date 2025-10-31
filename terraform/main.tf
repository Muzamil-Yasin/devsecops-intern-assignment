
# ===========================================================
# S3 Bucket for CodePipeline Artifacts
# ===========================================================

# Generate a random suffix to make the bucket name globally unique
resource "random_id" "suffix" {
  byte_length = 4
}

resource "aws_s3_bucket" "artifact_bucket" {
  bucket        = "muzamil-project-artifacts-bucket-${random_id.suffix.hex}"
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

# Enable versioning for safer artifact storage
resource "aws_s3_bucket_versioning" "artifact_versioning" {
  bucket = aws_s3_bucket.artifact_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}

# Enable server-side encryption (security best practice)
resource "aws_s3_bucket_server_side_encryption_configuration" "artifact_encryption" {
  bucket = aws_s3_bucket.artifact_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# Output the bucket name for referencing in other resources
output "artifact_bucket_name" {
  value = aws_s3_bucket.artifact_bucket.bucket
}
