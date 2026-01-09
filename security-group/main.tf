# ---------------------------------------------------------------------------------------------------------------------
# SECURITY GROUP MODULE
# A minimal security group module for teaching Terragrunt fundamentals.
# Creates a security group with configurable ingress and egress rules.
# ---------------------------------------------------------------------------------------------------------------------

resource "aws_security_group" "this" {
  name        = var.name
  description = var.description
  vpc_id      = var.vpc_id

  tags = merge(
    var.tags,
    {
      Name = var.name
    }
  )

  lifecycle {
    create_before_destroy = true
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# INGRESS RULES
# ---------------------------------------------------------------------------------------------------------------------

resource "aws_security_group_rule" "ingress" {
  count = length(var.ingress_rules)

  type              = "ingress"
  security_group_id = aws_security_group.this.id

  from_port   = var.ingress_rules[count.index].port
  to_port     = var.ingress_rules[count.index].port
  protocol    = lookup(var.ingress_rules[count.index], "protocol", "tcp")
  cidr_blocks = [var.ingress_rules[count.index].cidr]
  description = lookup(var.ingress_rules[count.index], "description", "Ingress rule ${count.index + 1}")
}

# ---------------------------------------------------------------------------------------------------------------------
# EGRESS RULES
# ---------------------------------------------------------------------------------------------------------------------

resource "aws_security_group_rule" "egress" {
  count = length(var.egress_rules)

  type              = "egress"
  security_group_id = aws_security_group.this.id

  from_port   = var.egress_rules[count.index].port
  to_port     = var.egress_rules[count.index].port
  protocol    = lookup(var.egress_rules[count.index], "protocol", "tcp")
  cidr_blocks = [var.egress_rules[count.index].cidr]
  description = lookup(var.egress_rules[count.index], "description", "Egress rule ${count.index + 1}")
}

# Default egress rule to allow all outbound traffic (common pattern)
resource "aws_security_group_rule" "default_egress" {
  count = var.allow_all_egress ? 1 : 0

  type              = "egress"
  security_group_id = aws_security_group.this.id

  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]
  description = "Allow all outbound traffic"
}
