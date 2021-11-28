locals {
  options = <<TOSTRINGA
----------------------------------------------------
---0.sso -------------------------------------------
----------------------------------------------------
Roles:  
    - Readonly: ${aws_iam_role.readonly.name}
    - Limited: ${aws_iam_role.limited.name}
    - Administrator: ${aws_iam_role.administrator.name}    
TOSTRINGA
}

output "toString" {
  value = local.options
}

