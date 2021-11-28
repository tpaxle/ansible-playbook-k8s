## Requirements

| Name | Version |
|------|---------|
| terraform | = 0.12.28 |
| aws | ~> 3.6 |

## Providers

| Name | Version |
|------|---------|
| aws | ~> 3.6 |
| kubernetes | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| az\_dns\_vault | Azure DNS CNAME record name | `string` | `"vault"` | no |
| default\_tags | Default Tags | `map(string)` | n/a | yes |
| github\_adminteam | n/a | `any` | n/a | yes |
| github\_organization | n/a | `any` | n/a | yes |
| region | The AWS region | `any` | n/a | yes |
| role\_arn | The assumed role ARN | `any` | n/a | yes |
| root\_infra\_domain | Infrastructure root domain | `any` | n/a | yes |
| root\_public\_domain | Infrastructure public domain | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| ci\_token | n/a |

