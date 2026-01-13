# ---------------------------------------------------------------------------------------------------------------------
# IAM ROLE MODULE
# A minimal IAM role module for teaching Terragrunt fundamentals.
# Useful for demonstrating merge strategies with the include block.
# ---------------------------------------------------------------------------------------------------------------------

# ---------------------------------------------------------------------------------------------------------------------
# IAM ROLE
# ---------------------------------------------------------------------------------------------------------------------

resource "aws_iam_role" "this" {
  name               = var.role_name
  assume_role_policy = var.assume_role_policy

  tags = var.tags
}

# ---------------------------------------------------------------------------------------------------------------------
# IAM POLICY
# ---------------------------------------------------------------------------------------------------------------------

resource "aws_iam_policy" "this" {
  name   = "${var.role_name}-policy"
  policy = jsonencode(var.iam_policy)
}

resource "aws_iam_role_policy_attachment" "this" {
  role       = aws_iam_role.this.name
  policy_arn = aws_iam_policy.this.arn
}
