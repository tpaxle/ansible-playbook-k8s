## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12 |

## Providers

| Name | Version |
|------|---------|
| aws | n/a |
| helm | n/a |
| template | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| access\_key | n/a | `any` | n/a | yes |
| default\_tags | Default Tags | `map(string)` | n/a | yes |
| enable\_k8s\_istio | Enable istio module installation | `bool` | `false` | no |
| enable\_k8s\_observability | Enable observability module installation | `bool` | `false` | no |
| kubernetes\_helm\_prometheusop\_chart\_name | Helm  Thanos chart version | `string` | `"stable/prometheus-operator"` | no |
| kubernetes\_helm\_prometheusop\_chart\_version | Helm  Prometheus operator chart version | `string` | `"8.13.8"` | no |
| observability\_depends\_on | n/a | `any` | `[]` | no |
| region | The AWS region | `any` | n/a | yes |
| root\_infra\_domain | Infrastructure domain | `any` | n/a | yes |
| root\_public\_domain | Infrastructure public domain | `any` | n/a | yes |
| secret\_key | n/a | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| stable-prometheus-operator | n/a |
| toString | n/a |

