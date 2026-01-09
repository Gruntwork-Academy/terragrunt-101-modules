# EC2 Instance Module

A minimal EC2 instance module for teaching Terragrunt fundamentals.

## Usage

```hcl
terraform {
  source = "git::https://github.com/gruntwork-io/terragrunt-101-modules.git//ec2-instance?ref=main"
}

inputs = {
  subnet_id          = dependency.vpc.outputs.public_subnet_ids[0]
  security_group_ids = [dependency.sg.outputs.security_group_id]
  instance_type      = "t3.micro"
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| subnet_id | The subnet ID for the instance | `string` | n/a | yes |
| security_group_ids | List of security group IDs | `list(string)` | n/a | yes |
| instance_name | Name tag for the instance | `string` | `"terragrunt-instance"` | no |
| instance_type | EC2 instance type | `string` | `"t3.micro"` | no |

## Outputs

| Name | Description |
|------|-------------|
| instance_id | The ID of the EC2 instance |
| public_ip | The public IP address |
