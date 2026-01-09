# EC2 Instance Module

Creates a single EC2 instance with configurable settings.

## Usage

```hcl
terraform {
  source = "git::https://github.com/gruntwork-io/terragrunt-101-modules.git//ec2-instance?ref=main"
}

inputs = {
  subnet_id          = dependency.vpc.outputs.public_subnet_ids[0]
  security_group_ids = [dependency.sg.outputs.security_group_id]
  instance_name      = "web-server"
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
| ami_id | AMI ID (defaults to latest Amazon Linux 2023) | `string` | `""` | no |
| key_name | SSH key pair name | `string` | `""` | no |
| associate_public_ip | Associate a public IP | `bool` | `true` | no |
| root_volume_size | Root volume size in GB | `number` | `20` | no |
| root_volume_type | Root volume type | `string` | `"gp3"` | no |
| encrypt_root_volume | Encrypt the root volume | `bool` | `true` | no |
| user_data | User data script | `string` | `""` | no |
| tags | Additional tags | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| instance_id | The ID of the EC2 instance |
| instance_arn | The ARN of the EC2 instance |
| public_ip | The public IP address |
| private_ip | The private IP address |
| public_dns | The public DNS name |
| private_dns | The private DNS name |
| ami_id | The AMI ID used |
