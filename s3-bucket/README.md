# S3 Bucket Module

Creates an S3 bucket with secure defaults: encryption, versioning, and public access blocked.

## Usage

```hcl
terraform {
  source = "git::https://github.com/gruntwork-io/terragrunt-101-modules.git//s3-bucket?ref=main"
}

inputs = {
  bucket_name        = "my-app-logs-bucket"
  versioning_enabled = true
  force_destroy      = false
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| bucket_name | Name of the S3 bucket (must be globally unique) | `string` | n/a | yes |
| versioning_enabled | Enable versioning | `bool` | `true` | no |
| force_destroy | Allow destruction of non-empty bucket | `bool` | `false` | no |
| enable_encryption | Enable server-side encryption | `bool` | `true` | no |
| kms_key_arn | ARN of KMS key (uses AES256 if empty) | `string` | `""` | no |
| block_public_acls | Block public ACLs | `bool` | `true` | no |
| block_public_policy | Block public bucket policies | `bool` | `true` | no |
| ignore_public_acls | Ignore public ACLs | `bool` | `true` | no |
| restrict_public_buckets | Restrict public bucket policies | `bool` | `true` | no |
| tags | Additional tags | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| bucket_id | The name of the bucket |
| bucket_arn | The ARN of the bucket |
| bucket_domain_name | The bucket domain name |
| bucket_regional_domain_name | The bucket region-specific domain name |
| bucket_region | The AWS region the bucket resides in |
