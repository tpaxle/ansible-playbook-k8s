## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| null | n/a |
| time | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| default\_tags | Default Tags | `map(string)` | n/a | yes |
| enable\_k8s\_istio | Enable istio module installation | `bool` | `false` | no |
| istio\_version | Istio version | `string` | `"1.6.8"` | no |
| region | The AWS region | `any` | n/a | yes |
| root\_infra\_domain | Infrastructure domain | `any` | n/a | yes |
| root\_public\_domain | Infrastructure public domain | `any` | n/a | yes |

## Outputs

No output.

