## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12 |

## Providers

| Name | Version |
|------|---------|
| null | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| default\_tags | Default Tags | `map(string)` | n/a | yes |
| elk\_depends\_on | n/a | `any` | `[]` | no |
| enable\_k8s\_elk | Enable elk module installation | `bool` | `false` | no |
| enable\_k8s\_istio | Enable istio module installation | `bool` | `false` | no |
| region | The AWS region | `any` | n/a | yes |
| role\_arn | The assumed role ARN | `any` | n/a | yes |
| root\_infra\_domain | Infrastructure root domain | `any` | n/a | yes |
| root\_public\_domain | Infrastructure public domain | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| toString | n/a |

