# ---------------------------------------------------------------------------------------------------------------------
# EC2 INSTANCE MODULE
# A minimal EC2 instance module for teaching Terragrunt fundamentals.
# Creates a single EC2 instance with configurable settings.
# ---------------------------------------------------------------------------------------------------------------------

# ---------------------------------------------------------------------------------------------------------------------
# DATA SOURCES
# ---------------------------------------------------------------------------------------------------------------------

# Get the latest Amazon Linux 2023 AMI
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# Get current AWS region
data "aws_region" "current" {}

# ---------------------------------------------------------------------------------------------------------------------
# EC2 INSTANCE
# ---------------------------------------------------------------------------------------------------------------------

resource "aws_instance" "this" {
  ami                    = var.ami_id != "" ? var.ami_id : data.aws_ami.amazon_linux.id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = var.security_group_ids
  key_name               = var.key_name != "" ? var.key_name : null

  associate_public_ip_address = var.associate_public_ip

  root_block_device {
    volume_size           = var.root_volume_size
    volume_type           = var.root_volume_type
    encrypted             = var.encrypt_root_volume
    delete_on_termination = true
  }

  user_data = var.user_data != "" ? var.user_data : null

  tags = merge(
    var.tags,
    {
      Name = var.instance_name
    }
  )

  volume_tags = merge(
    var.tags,
    {
      Name = "${var.instance_name}-root"
    }
  )

  lifecycle {
    ignore_changes = [ami]
  }
}
