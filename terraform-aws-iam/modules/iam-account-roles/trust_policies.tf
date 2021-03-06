data "aws_iam_policy_document" "assume_admin_role_with_mfa" {
  count = var.admin_role_requires_mfa && length(var.admin_role_cross_account_ids) > 0 ? 1 : 0
  statement {
    effect = "Allow"

    actions = ["sts:AssumeRole"]

    principals {
      type        = "AWS"
      identifiers = formatlist("arn:aws:iam::%s:root", var.admin_role_cross_account_ids)
    }
    condition {
      test     = "Bool"
      variable = "aws:MultiFactorAuthPresent"
      values   = ["true"]
    }

    condition {
      test     = "NumericLessThan"
      variable = "aws:MultiFactorAuthAge"
      values   = [var.admin_role_mfa_age]
    }

    dynamic "condition" {
      for_each = var.admin_role_conditions
      content {
        test     = condition.value.test
        variable = condition.value.variable
        values   = condition.value.values
      }
    }

  }
}

data "aws_iam_policy_document" "assume_admin_role" {
  count = var.admin_role_requires_mfa != true && length(var.admin_role_cross_account_ids) > 0 ? 1 : 0
  statement {
    effect = "Allow"

    actions = ["sts:AssumeRole"]

    principals {
      type        = "AWS"
      identifiers = formatlist("arn:aws:iam::%s:root", var.admin_role_cross_account_ids)
    }

    dynamic "condition" {
      for_each = var.admin_role_conditions
      content {
        test     = condition.value.test
        variable = condition.value.variable
        values   = condition.value.values
      }
    }
  }
}

data "aws_iam_policy_document" "assume_dev_role_with_mfa" {
  count = var.dev_role_requires_mfa && length(var.dev_role_cross_account_ids) > 0 ? 1 : 0
  statement {
    effect = "Allow"

    actions = ["sts:AssumeRole"]

    principals {
      type        = "AWS"
      identifiers = formatlist("arn:aws:iam::%s:root", var.dev_role_cross_account_ids)
    }
    condition {
      test     = "Bool"
      variable = "aws:MultiFactorAuthPresent"
      values   = ["true"]
    }

    condition {
      test     = "NumericLessThan"
      variable = "aws:MultiFactorAuthAge"
      values   = [var.dev_role_mfa_age]
    }

    dynamic "condition" {
      for_each = var.dev_role_conditions
      content {
        test     = condition.value.test
        variable = condition.value.variable
        values   = condition.value.values
      }
    }

  }
}



data "aws_iam_policy_document" "assume_dev_role" {
  count = var.dev_role_requires_mfa != true && length(var.dev_role_cross_account_ids) > 0 ? 1 : 0
  statement {
    effect = "Allow"

    actions = ["sts:AssumeRole"]

    principals {
      type        = "AWS"
      identifiers = formatlist("arn:aws:iam::%s:root", var.dev_role_cross_account_ids)
    }

    dynamic "condition" {
      for_each = var.dev_role_conditions
      content {
        test     = condition.value.test
        variable = condition.value.variable
        values   = condition.value.values
      }
    }
  }
}


data "aws_iam_policy_document" "assume_read_role_with_mfa" {
  count = var.read_role_requires_mfa && length(var.read_role_cross_account_ids) > 0 ? 1 : 0
  statement {
    effect = "Allow"

    actions = ["sts:AssumeRole"]

    principals {
      type        = "AWS"
      identifiers = formatlist("arn:aws:iam::%s:root", var.read_role_cross_account_ids)
    }
    condition {
      test     = "Bool"
      variable = "aws:MultiFactorAuthPresent"
      values   = ["true"]
    }

    condition {
      test     = "NumericLessThan"
      variable = "aws:MultiFactorAuthAge"
      values   = [var.read_role_mfa_age]
    }

    dynamic "condition" {
      for_each = var.read_role_conditions
      content {
        test     = condition.value.test
        variable = condition.value.variable
        values   = condition.value.values
      }
    }

  }
}



data "aws_iam_policy_document" "assume_read_role" {
  count = var.read_role_requires_mfa != true && length(var.read_role_cross_account_ids) > 0 ? 1 : 0
  statement {
    effect = "Allow"

    actions = ["sts:AssumeRole"]

    principals {
      type        = "AWS"
      identifiers = formatlist("arn:aws:iam::%s:root", var.read_role_cross_account_ids)
    }

    dynamic "condition" {
      for_each = var.read_role_conditions
      content {
        test     = condition.value.test
        variable = condition.value.variable
        values   = condition.value.values
      }
    }
  }
}

data "aws_iam_policy_document" "assume_tf_plan_role" {
  count = length(var.tf_plan_role_cross_account_ids) > 0 ? 1 : 0
  statement {
    effect = "Allow"

    actions = ["sts:AssumeRole"]

    principals {
      type        = "AWS"
      identifiers = formatlist("arn:aws:iam::%s:root", var.tf_plan_role_cross_account_ids)
    }

    dynamic "condition" {
      for_each = var.tf_plan_role_conditions
      content {
        test     = condition.value.test
        variable = condition.value.variable
        values   = condition.value.values
      }
    }
  }
}

data "aws_iam_policy_document" "assume_tf_apply_role" {
  count = length(var.tf_apply_role_cross_account_ids) > 0 ? 1 : 0
  statement {
    effect = "Allow"

    actions = ["sts:AssumeRole"]

    principals {
      type        = "AWS"
      identifiers = formatlist("arn:aws:iam::%s:root", var.tf_apply_role_cross_account_ids)
    }

    dynamic "condition" {
      for_each = var.tf_apply_role_conditions
      content {
        test     = condition.value.test
        variable = condition.value.variable
        values   = condition.value.values
      }
    }
  }
}

data "aws_iam_policy_document" "assume_limited_s3_read_role" {
  count = length(var.limited_s3_read_role_cross_account_ids) > 0 ? 1 : 0
  statement {
    effect = "Allow"

    actions = ["sts:AssumeRole"]

    principals {
      type        = "AWS"
      identifiers = formatlist("arn:aws:iam::%s:root", var.limited_s3_read_role_cross_account_ids)
    }

    dynamic "condition" {
      for_each = var.limited_s3_read_role_conditions
      content {
        test     = condition.value.test
        variable = condition.value.variable
        values   = condition.value.values
      }
    }
  }
}

data "aws_iam_policy_document" "assume_cd_role" {
  count = length(var.cd_role_cross_account_ids) > 0 ? 1 : 0
  statement {
    effect = "Allow"

    actions = ["sts:AssumeRole"]

    principals {
      type        = "AWS"
      identifiers = formatlist("arn:aws:iam::%s:root", var.cd_role_cross_account_ids)
    }

    dynamic "condition" {
      for_each = var.cd_role_conditions
      content {
        test     = condition.value.test
        variable = condition.value.variable
        values   = condition.value.values
      }
    }
  }
}