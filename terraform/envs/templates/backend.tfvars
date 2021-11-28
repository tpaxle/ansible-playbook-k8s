#role_arn = "arn:aws:iam::551692124473:role/OrganizationAccountAccessRole"
role_arn      = "{{var_aws_authentication_role_arn}}"
bucket        = "{{var_aws_authentication_bucket}}"
region        = "{{var_aws_authentication_region}}"

dynamodb_table = "{{var_aws_ccoedata_application}}-tf-state-{{var_aws_ccoedata_environment}}"
access_key     = "{{var_aws_authentication_access_key_id}}"
secret_key     = "{{var_aws_authentication_secret_access_key}}"
