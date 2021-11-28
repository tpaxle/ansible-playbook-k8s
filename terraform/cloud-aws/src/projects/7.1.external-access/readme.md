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
| dns | n/a |
| kubernetes | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| api\_gw\_domain\_name | DNS hostname for the api <api\_dns>.<rood\_domain> | `any` | n/a | yes |
| az\_dns\_name | Dns domain zone in azure | `any` | n/a | yes |
| az\_dns\_vault | Azure DNS CNAME record name | `string` | `"vault"` | no |
| az\_rg\_name | Resource group where azure dns is | `any` | n/a | yes |
| bucket | The name of the tfstate bucket | `any` | n/a | yes |
| client\_id | Specifies the id of the service principal. | `any` | n/a | yes |
| client\_secret | Specifies the secret of the service principal. | `any` | n/a | yes |
| default\_tags | Default Tags | `map(string)` | n/a | yes |
| enable\_k8s\_istio | Enable istio module installation | `bool` | `false` | no |
| enable\_k8s\_security | Enable security module installation | `bool` | `false` | no |
| naming\_convention\_definition | Naming Convention Definition | `map(string)` | `{}` | no |
| region | The AWS region | `any` | n/a | yes |
| role\_arn | The assumed role ARN | `any` | n/a | yes |
| root\_public\_domain | Infrastructure root domain | `any` | n/a | yes |
| subscription\_id | Specifies the secret of the service principal. | `any` | n/a | yes |
| vault\_enable\_public | Enable public load balancer | `string` | `"0"` | no |

## Outputs

| Name | Description |
|------|-------------|
| toString | n/a |

