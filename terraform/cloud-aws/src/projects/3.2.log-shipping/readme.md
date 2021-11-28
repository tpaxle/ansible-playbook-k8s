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
| cloudwatch\_log\_groups | n/a | `list` | n/a | yes |
| default\_tags | Default Tags | `map(string)` | n/a | yes |
| enable\_cloudtrail | Create cloudtrail event flag | `bool` | `false` | no |
| naming\_convention\_definition | Naming Convention Definition | `map(string)` | `{}` | no |
| region | The AWS region | `any` | n/a | yes |
| role\_arn | n/a | `any` | n/a | yes |
| root\_role\_arn | n/a | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| toString | n/a |

