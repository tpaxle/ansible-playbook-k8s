## Requirements

| Name | Version |
|------|---------|
| terraform | = 0.12.28 |
| terraform | >= 0.12 |
| aws | ~> 3.6 |
| helm | ~> 1.2.4 |

## Providers

| Name | Version |
|------|---------|
| aws | ~> 3.6 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| access\_key | n/a | `any` | n/a | yes |
| default\_tags | Default Tags | `map(string)` | n/a | yes |
| enable\_k8s\_istio | Enable istio module installation (observability is needed in case of this will be true) | `bool` | `false` | no |
| enable\_k8s\_observability | Enable observability module installation | `bool` | `false` | no |
| kubernetes\_helm\_prometheusop\_chart\_name | Helm  Thanos chart version | `string` | `"stable/prometheus-operator"` | no |
| kubernetes\_helm\_prometheusop\_chart\_version | Helm  Prometheus operator chart version | `string` | `"8.13.8"` | no |
| region | The AWS region | `any` | n/a | yes |
| role\_arn | The assumed role ARN | `any` | n/a | yes |
| root\_infra\_domain | Infrastructure root domain | `any` | n/a | yes |
| root\_public\_domain | Infrastructure public domain | `any` | n/a | yes |
| secret\_key | n/a | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| toString | n/a |

