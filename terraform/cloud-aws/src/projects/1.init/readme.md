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
| elb\_log\_accounts | Amazon provided aws account IDs to be used for elb logs. | `map(string)` | <pre>{<br>  "eu-west-1": "156460612806",<br>  "eu-west-2": "652711504416"<br>}</pre> | no |
| envs\_path | Environment relative folder path | `string` | `"../../../envs"` | no |
| naming\_convention\_definition | Naming Convention Definition | `map(string)` | `{}` | no |
| region | The AWS region | `any` | n/a | yes |
| role\_arn | n/a | `any` | n/a | yes |
| root\_account | n/a | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| toString | n/a |

