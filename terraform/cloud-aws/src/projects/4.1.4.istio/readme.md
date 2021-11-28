## Requirements

| Name | Version |
|------|---------|
| terraform | = 0.12.28 |
| aws | ~> 3.6 |

## Providers

| Name | Version |
|------|---------|
| aws | ~> 3.6 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| default\_tags | Default Tags | `map(string)` | n/a | yes |
| enable\_k8s\_istio | Enable istio module installation | `bool` | `false` | no |
| region | The AWS region | `any` | n/a | yes |
| role\_arn | The assumed role ARN | `any` | n/a | yes |
| root\_infra\_domain | Infrastructure root domain | `any` | n/a | yes |
| root\_public\_domain | Infrastructure public domain | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| toString | n/a |

