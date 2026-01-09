# VPC Module

A minimal VPC module for teaching Terragrunt fundamentals. Creates a VPC with public and private subnets, internet gateway, and optional NAT gateway.

## Usage

```hcl
terraform {
  source = "git::https://github.com/gruntwork-io/terragrunt-101-modules.git//vpc?ref=main"
}

inputs = {
  vpc_cidr    = "10.0.0.0/16"
  environment = "dev"
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| vpc_cidr | The CIDR block for the VPC | `string` | n/a | yes |
| environment | Environment name (e.g., dev, staging, prod) | `string` | n/a | yes |
| availability_zones | List of availability zones | `list(string)` | `["us-east-1a", "us-east-1b"]` | no |
| public_subnet_cidrs | CIDR blocks for public subnets | `list(string)` | `["10.0.1.0/24", "10.0.2.0/24"]` | no |
| private_subnet_cidrs | CIDR blocks for private subnets | `list(string)` | `["10.0.10.0/24", "10.0.11.0/24"]` | no |
| project_name | Project name for tagging | `string` | `""` | no |
| enable_nat_gateway | Enable NAT Gateway (costs money) | `bool` | `true` | no |
| tags | Additional tags | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| vpc_id | The ID of the VPC |
| public_subnet_ids | List of public subnet IDs |
| private_subnet_ids | List of private subnet IDs |
| nat_gateway_ids | List of NAT Gateway IDs |
