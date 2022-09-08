locals {
    other_aws_account_id = "796723948741"
}

module "s3_bucket_test" {
    source = "./modules/s3_bucket"
    bucket_name = "meyerkev-iam-test"
}

module "s3_bucket_test_with_tags" {
    source = "./modules/s3_bucket"
    bucket_name = "meyerkev-iam-test-with-tags"
    bucket_tags = {
        test1 = "value1"
        test2 = "value2"
    }
}

module "s3_bucket_test_no_encryption" {
    source = "./modules/s3_bucket"
    bucket_name = "meyerkev-iam-test-no-encryption"
    encrypted = false
}

resource "aws_kms_key" "test" {
}

module "s3_bucket_test_custom_kms" {
    source = "./modules/s3_bucket"
    bucket_name = "meyerkev-iam-test-custom-encryption"
    kms_key_arn = aws_kms_key.test.arn
}

module "s3_bucket_test_custom_policy" {
    source = "./modules/s3_bucket"
    bucket_name = "meyerkev-iam-test-custom-policy"
}

data "aws_iam_policy_document" "allow_access_from_another_account" {
  statement {
    principals {
      type        = "AWS"
      identifiers = [local.other_aws_account_id]
    }

    actions = [
      "s3:GetObject",
      "s3:ListBucket",
    ]

    # This is not ideal, but I wanted to show how this could be attached
    # Really, you ought to get the exposed bucket, then attach the policy to it outside the module
    resources = [
      module.s3_bucket_test_custom_policy.bucket.arn,
      "${module.s3_bucket_test_custom_policy.bucket.arn}/*",
    ]
  }
}

resource "aws_s3_bucket_policy" "allow_access_from_another_account" {
    bucket = module.s3_bucket_test_custom_policy.bucket.id
    policy = data.aws_iam_policy_document.allow_access_from_another_account.json
}

module "s3_bucket_test_public" {
    source = "./modules/s3_bucket"
    bucket_name = "meyerkev-iam-test-public-read"
    bucket_acl = "public-read"
    public = true
}


