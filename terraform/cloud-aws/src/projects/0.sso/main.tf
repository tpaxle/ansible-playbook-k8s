
data "aws_caller_identity" "current" {
}


data "template_file" "trust-policy" {
  template = file("templates/trust-policy.json")

  vars = {
    account_number = data.aws_caller_identity.current.account_id
    vault_user_arn = var.vault_user_arn
    #provider_name  = aws_iam_saml_provider.sso-azure.name
  }
}

/* READ ONLY ROLE */

data "aws_iam_policy" "readonly" {
  arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}

resource "aws_iam_role" "readonly" {
  name = "${var.default_tags["_Application"]}-${var.default_tags["_Environment"]}-sso-readonly"

  assume_role_policy = data.template_file.trust-policy.rendered
}

resource "aws_iam_role_policy_attachment" "readonly-role-policy-attach" {
  role       = aws_iam_role.readonly.name
  policy_arn = data.aws_iam_policy.readonly.arn
}

resource "aws_iam_role_policy_attachment" "readonly-billing-policy-attach" {
  role       = aws_iam_role.readonly.name
  policy_arn = aws_iam_policy.readonly-billing.arn
}

resource "aws_iam_policy" "readonly-billing" {
  name        = "${var.default_tags["_Application"]}-${var.default_tags["_Environment"]}-billing-readonly-policy"
  path        = "/"
  description = "Readonly billing policy"

  policy = file("data/readonly-billing-policy.json")
}

/* LIMITED ROLE */

resource "aws_iam_policy" "limited" {
  name        = "${var.default_tags["_Application"]}-${var.default_tags["_Environment"]}-sso-limited-policy"
  path        = "/"
  description = "Limited access using SSO"

  policy = file("data/limited-policy.json")
}

resource "aws_iam_role" "limited" {
  name = "${var.default_tags["_Application"]}-${var.default_tags["_Environment"]}-sso-limited"

  assume_role_policy = data.template_file.trust-policy.rendered
}

resource "aws_iam_role_policy_attachment" "limited-role-policy-attach" {
  role       = aws_iam_role.limited.name
  policy_arn = aws_iam_policy.limited.arn
}

/* ADMINISTRATOR ROLE */

data "aws_iam_policy" "administrator" {
  arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_role" "administrator" {
  name = "${var.default_tags["_Application"]}-${var.default_tags["_Environment"]}-sso-administrator"

  assume_role_policy = data.template_file.trust-policy.rendered
}

resource "aws_iam_role_policy_attachment" "administrator-role-policy-attach" {
  role       = aws_iam_role.administrator.name
  policy_arn = data.aws_iam_policy.administrator.arn
}

