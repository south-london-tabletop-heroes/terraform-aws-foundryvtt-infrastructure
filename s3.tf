resource "aws_s3_bucket" "foundryvtt_infrastructure_s3_state" {
  bucket        = format("foundryvtt-infrastructure-%s-s3-state", var.name)
  force_destroy = true
  versioning {
    enabled = true
  }
}

resource "aws_s3_bucket" "foundryvtt_infrastructure_s3_media" {
  bucket        = format("foundryvtt-infrastructure-%s-s3-media", var.name)
  force_destroy = true
  versioning {
    enabled = true
  }
  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["GET", "POST", "HEAD"]
    allowed_origins = ["*"]
    max_age_seconds = 3000
  }
}

resource "aws_s3_bucket_public_access_block" "foundryvtt_infrastructure_s3_state" {
  bucket                  = aws_s3_bucket.foundryvtt_infrastructure_s3_state.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_public_access_block" "foundryvtt_infrastructure_s3_media" {
  bucket                  = aws_s3_bucket.foundryvtt_infrastructure_s3_media.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
