# Path Explorer Module
# This module doesn't create any resources - it's used to demonstrate
# how Terragrunt's path functions resolve to different values based on
# the unit's location in the directory structure.

terraform {
  required_version = ">= 1.0"
}

# Output all the path function values for inspection
output "path_functions" {
  description = "Values returned by Terragrunt path functions"
  value = {
    terragrunt_dir      = var.terragrunt_dir
    repo_root           = var.repo_root
    path_from_root      = var.path_from_root
    relative_to_include = var.relative_to_include
    state_key           = var.state_key
  }
}

output "extracted_context" {
  description = "Context extracted from directory structure"
  value = {
    account     = var.account
    region      = var.region
    environment = var.environment
    unit_name   = var.unit_name
  }
}

output "hierarchical_config" {
  description = "Values read from hierarchical .hcl files"
  value = {
    account_id       = var.account_id
    aws_region       = var.aws_region
    environment_tier = var.environment_tier
  }
}

output "computed_tags" {
  description = "Tags built from path context"
  value       = var.tags
}
