# Path function outputs - these show what each function returns
variable "terragrunt_dir" {
  description = "Value from get_terragrunt_dir()"
  type        = string
}

variable "repo_root" {
  description = "Value from get_repo_root()"
  type        = string
}

variable "path_from_root" {
  description = "Value from get_path_from_repo_root()"
  type        = string
}

variable "relative_to_include" {
  description = "Value from path_relative_to_include()"
  type        = string
}

variable "state_key" {
  description = "Computed state key using path functions"
  type        = string
}

# Extracted context from directory structure
variable "account" {
  description = "Account name extracted from path"
  type        = string
}

variable "region" {
  description = "Region extracted from path"
  type        = string
}

variable "environment" {
  description = "Environment extracted from path"
  type        = string
}

variable "unit_name" {
  description = "Unit name extracted from path"
  type        = string
}

# Values from hierarchical config files
variable "account_id" {
  description = "AWS account ID from account.hcl"
  type        = string
}

variable "aws_region" {
  description = "AWS region from region.hcl"
  type        = string
}

variable "environment_tier" {
  description = "Environment tier from env.hcl"
  type        = string
}

variable "tags" {
  description = "Common tags built from path context"
  type        = map(string)
  default     = {}
}
