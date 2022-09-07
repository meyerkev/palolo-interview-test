resource "aws_s3_bucket" "this" {
  bucket = var.bucket_name
  
  tags = var.bucket_tags
}

resource "aws_s3_bucket_server_side_encryption_configuration" "this" {
    count = var.encrypted ? 1 : 0
    bucket = aws_s3_bucket.this.bucket

    rule {
        apply_server_side_encryption_by_default {
            # By not setting kms_master_key_id
            kms_master_key_id = var.kms_key_arn
            sse_algorithm     = "aws:kms"
        }
    }
}

resource "aws_s3_bucket_acl" "this" {
    count = var.bucket_acl != null ? 1 : 0
    bucket = aws_s3_bucket.this.id
    # Alt: Default this to private acl
    # TODO when we permit custom grants, work around that grant
    acl    = var.bucket_acl
}

resource "aws_s3_bucket_public_access_block" "this" {
    count = var.public ? 0 : 1
    bucket = aws_s3_bucket.this.id

    block_public_acls       = true
    block_public_policy     = true
    ignore_public_acls      = true
    restrict_public_buckets = true
}

resource "aws_s3_bucket_policy" "this" {
    count = var.bucket_policy != null ? 1 : 0
    bucket = aws_s3_bucket.this.id
    policy = var.bucket_policy
}