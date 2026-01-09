# S3 Bucket Module

Creates an S3 bucket with secure defaults: AES256 encryption, versioning, and public access blocked.

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
| block_public_acls | Block public ACLs | `bool` | `true` | no |
| block_public_policy | Block public bucket policies | `bool` | `true` | no |
| tags | Additional tags | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| bucket_id | The name of the bucket |
| bucket_arn | The ARN of the bucket |
