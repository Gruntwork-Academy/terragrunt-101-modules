# ---------------------------------------------------------------------------------------------------------------------
# REQUIRED VARIABLES
# ---------------------------------------------------------------------------------------------------------------------

variable "name" {
  description = "Name for the security group"
  type        = string
}

variable "vpc_id" {
  description = "The VPC ID where the security group will be created"
  type        = string
}

# ---------------------------------------------------------------------------------------------------------------------
# OPTIONAL VARIABLES
# ---------------------------------------------------------------------------------------------------------------------

variable "description" {
  description = "Description for the security group"
  type        = string
  default     = "Managed by Terraform"
}

variable "ingress_rules" {
  description = "List of ingress rules. Each rule is an object with port, cidr, and optional protocol and description."
  type = list(object({
    port        = number
    cidr        = string
    protocol    = optional(string, "tcp")
    description = optional(string)
  }))
  default = []
}

variable "egress_rules" {
  description = "List of egress rules. Each rule is an object with port, cidr, and optional protocol and description."
  type = list(object({
    port        = number
    cidr        = string
    protocol    = optional(string, "tcp")
    description = optional(string)
  }))
  default = []
}

variable "allow_all_egress" {
  description = "Whether to allow all outbound traffic by default"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Additional tags to apply to the security group"
  type        = map(string)
  default     = {}
}
