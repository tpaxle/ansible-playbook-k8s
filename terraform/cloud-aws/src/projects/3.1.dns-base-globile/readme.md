## Requirements

| Name | Version |
|------|---------|
| terraform | = 0.12.28 |
| terraform | >= 0.12 |
| aws | ~> 3.6 |
| aws | ~> 3.6 |
| aws | ~> 3.6 |

## Providers

| Name | Version |
|------|---------|
| aws | ~> 3.6 ~> 3.6 ~> 3.6 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| default\_tags | Default Tags | `map(string)` | n/a | yes |
| naming\_convention\_definition | Naming Convention Definition | `map(string)` | `{}` | no |
| region | The AWS region | `any` | n/a | yes |
| role\_arn | n/a | `any` | n/a | yes |
| root\_infra\_domain | Infrastructure domain | `any` | n/a | yes |
| root\_public\_domain | Public domain | `any` | n/a | yes |
| root\_role\_arn | n/a | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| toString | n/a |

