# Security Group Module

Creates a security group with configurable ingress and egress rules.

## Usage

```hcl
terraform {
  source = "git::https://github.com/gruntwork-io/terragrunt-101-modules.git//security-group?ref=main"
}

inputs = {
  vpc_id = dependency.vpc.outputs.vpc_id
  name   = "web-sg"
  
  ingress_rules = [
    { port = 80, cidr = "0.0.0.0/0", description = "HTTP" },
    { port = 443, cidr = "0.0.0.0/0", description = "HTTPS" },
    { port = 22, cidr = "10.0.0.0/8", description = "SSH from internal" }
  ]
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| name | Name for the security group | `string` | n/a | yes |
| vpc_id | The VPC ID | `string` | n/a | yes |
| description | Description for the security group | `string` | `"Managed by Terraform"` | no |
| ingress_rules | List of ingress rules | `list(object)` | `[]` | no |
| egress_rules | List of egress rules | `list(object)` | `[]` | no |
| allow_all_egress | Allow all outbound traffic by default | `bool` | `true` | no |
| tags | Additional tags | `map(string)` | `{}` | no |

### Ingress/Egress Rule Object

```hcl
{
  port        = 443
  cidr        = "0.0.0.0/0"
  protocol    = "tcp"      # optional, defaults to "tcp"
  description = "HTTPS"    # optional
}
```

## Outputs

| Name | Description |
|------|-------------|
| security_group_id | The ID of the security group |
| security_group_arn | The ARN of the security group |
| security_group_name | The name of the security group |
