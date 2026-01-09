# Terragrunt 101 Modules

Minimal Terraform/OpenTofu modules for the **Terragrunt for AWS** course.

These modules are intentionally simple and designed for teaching Terragrunt fundamentals. For production workloads, consider using the [Gruntwork Library](https://gruntwork.io/library).

## Modules

| Module | Description | Key Inputs | Key Outputs |
|--------|-------------|------------|-------------|
| [vpc](./vpc) | VPC with public/private subnets, IGW, and NAT | `vpc_cidr`, `environment` | `vpc_id`, `public_subnet_ids`, `private_subnet_ids` |
| [security-group](./security-group) | Security group with configurable rules | `vpc_id`, `name`, `ingress_rules` | `security_group_id` |
| [ec2-instance](./ec2-instance) | Single EC2 instance | `subnet_id`, `security_group_ids` | `instance_id`, `public_ip` |
| [s3-bucket](./s3-bucket) | S3 bucket with security defaults | `bucket_name` | `bucket_id`, `bucket_arn` |

## Usage with Terragrunt

### Scaffold from this catalog

```bash
terragrunt scaffold https://github.com/gruntwork-io/terragrunt-101-modules//vpc
```

### Reference in terragrunt.hcl

```hcl
terraform {
  source = "git::https://github.com/gruntwork-io/terragrunt-101-modules.git//vpc?ref=main"
}

inputs = {
  vpc_cidr    = "10.0.0.0/16"
  environment = "dev"
}
```

### Local development

```hcl
terraform {
  source = "../../../modules/vpc"
}
```

## Example: Multi-Unit Stack

Here's how to compose these modules into a stack:

```
app-stack/
├── root.hcl
├── vpc/
│   └── terragrunt.hcl
├── security-group/
│   └── terragrunt.hcl
└── web-server/
    └── terragrunt.hcl
```

**vpc/terragrunt.hcl:**
```hcl
terraform {
  source = "git::https://github.com/gruntwork-io/terragrunt-101-modules.git//vpc?ref=main"
}

include "root" {
  path = find_in_parent_folders("root.hcl")
}

inputs = {
  vpc_cidr    = "10.0.0.0/16"
  environment = "dev"
}
```

**security-group/terragrunt.hcl:**
```hcl
terraform {
  source = "git::https://github.com/gruntwork-io/terragrunt-101-modules.git//security-group?ref=main"
}

include "root" {
  path = find_in_parent_folders("root.hcl")
}

dependency "vpc" {
  config_path = "../vpc"
  
  mock_outputs = {
    vpc_id = "vpc-mock"
  }
  mock_outputs_allowed_terraform_commands = ["validate", "plan"]
}

inputs = {
  vpc_id = dependency.vpc.outputs.vpc_id
  name   = "web-sg"
  ingress_rules = [
    { port = 80, cidr = "0.0.0.0/0" },
    { port = 443, cidr = "0.0.0.0/0" }
  ]
}
```

**web-server/terragrunt.hcl:**
```hcl
terraform {
  source = "git::https://github.com/gruntwork-io/terragrunt-101-modules.git//ec2-instance?ref=main"
}

include "root" {
  path = find_in_parent_folders("root.hcl")
}

dependency "vpc" {
  config_path = "../vpc"
  
  mock_outputs = {
    public_subnet_ids = ["subnet-mock"]
  }
  mock_outputs_allowed_terraform_commands = ["validate", "plan"]
}

dependency "security_group" {
  config_path = "../security-group"
  
  mock_outputs = {
    security_group_id = "sg-mock"
  }
  mock_outputs_allowed_terraform_commands = ["validate", "plan"]
}

inputs = {
  subnet_id          = dependency.vpc.outputs.public_subnet_ids[0]
  security_group_ids = [dependency.security_group.outputs.security_group_id]
  instance_name      = "web-server"
  instance_type      = "t3.micro"
}
```

## Requirements

- Terraform >= 1.0 or OpenTofu >= 1.6
- AWS Provider >= 5.0
- Terragrunt >= 0.50

## License

Apache 2.0
