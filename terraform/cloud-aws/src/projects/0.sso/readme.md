## Requirements

| Name | Version |
|------|---------|
| terraform | = 0.12.28 |
| terraform | >= 0.12 |
| aws | ~> 3.6 |

## Providers

| Name | Version |
|------|---------|
| aws | ~> 3.6 |
| template | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| default\_tags | Default Tags | `map(string)` | n/a | yes |
| region | Region to base all of our commands on | `any` | n/a | yes |
| vault\_user\_arn | ARN of Vault user that is used to assume SSO roles in this account | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| toString | n/a |

