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
| time | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| bucket | The name of the tfstate bucket | `any` | n/a | yes |
| default\_tags | Default Tags | `map(string)` | n/a | yes |
| kubernetes\_helm\_certmanager\_chart\_name | Helm  Cert Manager chart version | `string` | `"cert-manager"` | no |
| kubernetes\_helm\_certmanager\_chart\_version | Helm Cert Manager chart version | `string` | `"1.0.1"` | no |
| kubernetes\_helm\_dashboard\_chart\_name | Helm Dashboard Chart Name | `string` | `"stable/kubernetes-dashboard"` | no |
| kubernetes\_helm\_dashboard\_chart\_version | Helm Dashboard chart version | `string` | `"1.10.1"` | no |
| kubernetes\_helm\_externaldns\_chart\_name | Helm  External DNS chart name | `string` | `"stable/external-dns"` | no |
| kubernetes\_helm\_externaldns\_chart\_version | Helm  External DNS chart version | `string` | `"2.20.4"` | no |
| kubernetes\_helm\_ingress\_chart\_name | Helm Ingress controller Chart Name | `string` | `"stable/nginx-ingress"` | no |
| kubernetes\_helm\_ingress\_chart\_version | Helm Ingress Controller Chart Version | `string` | `"1.36.3"` | no |
| kubernetes\_helm\_kube-sm\_chart\_name | Helm Kube Static Metrics Chart Version | `string` | `"stable/kube-state-metrics"` | no |
| kubernetes\_helm\_kube-sm\_chart\_version | Helm Kube Static Metrics Chart Version | `string` | `"2.8.4"` | no |
| kubernetes\_helm\_metrics-server\_chart\_name | Helm  Metrics Server Chart Name | `string` | `"stable/metrics-server"` | no |
| kubernetes\_helm\_metrics-server\_chart\_version | Helm  Metrics Server Chart Version | `string` | `"2.11.1"` | no |
| region | The AWS region | `any` | n/a | yes |
| role\_arn | The assumed role ARN | `any` | n/a | yes |
| root\_infra\_domain | Infrastructure root domain | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| toString | n/a |

