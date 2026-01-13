# IAM Role Module

A minimal IAM role module for teaching Terragrunt fundamentals. This module is particularly useful for demonstrating merge strategies with the `include` block, as the `iam_policy` input can be defined at different levels of the Terragrunt hierarchy and merged together.

## Usage

```hcl
terraform {
  source = "git::https://github.com/gruntwork-io/terragrunt-101-modules.git//iam-role?ref=main"
}

inputs = {
  role_name = "my-app-role"

  iam_policy = {
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = ["s3:GetObject", "s3:ListBucket"]
        Resource = ["arn:aws:s3:::my-bucket", "arn:aws:s3:::my-bucket/*"]
      }
    ]
  }
}
```

## Demonstrating Merge Strategies

This module is ideal for demonstrating Terragrunt's `merge_strategy` options in `include` blocks:

- **`no_merge`** (default): Child completely overrides parent's `iam_policy`
- **`shallow`**: Top-level keys are merged, but nested objects are replaced
- **`deep`**: Recursively merges nested objects (useful for combining policy statements)

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| role_name | The name of the IAM role | `string` | n/a | yes |
| iam_policy | The IAM policy document in JSON format | `string` | n/a | yes |
| assume_role_policy | The assume role policy document | `string` | EC2 assume role | no |
| tags | Tags to apply to the IAM role | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| role_arn | The ARN of the IAM role |
| role_name | The name of the IAM role |
| policy_arn | The ARN of the IAM policy |
