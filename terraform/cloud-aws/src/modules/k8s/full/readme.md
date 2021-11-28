## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12 |

## Providers

| Name | Version |
|------|---------|
| time | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| access\_key | n/a | `any` | n/a | yes |
| default\_tags | Default Tags | `map(string)` | n/a | yes |
| enable\_k8s\_elk | Enable elk module installation | `bool` | `true` | no |
| enable\_k8s\_istio | Enable istio module installation | `bool` | `true` | no |
| enable\_k8s\_keycloak | Enable keycloak installation | `bool` | `true` | no |
| enable\_k8s\_observability | Enable observability module installation | `bool` | `true` | no |
| enable\_k8s\_security | Enable security module installation | `bool` | `true` | no |
| kubernetes\_helm\_certmanager\_chart\_name | Helm  Cert Manager chart version | `string` | `"cert-manager"` | no |
| kubernetes\_helm\_certmanager\_chart\_version | Helm Cert Manager chart version | `string` | `"1.0.1"` | no |
| kubernetes\_helm\_dashboard\_chart\_name | Helm Dashboard Chart Name | `string` | `"stable/kubernetes-dashboard"` | no |
| kubernetes\_helm\_dashboard\_chart\_version | Helm Dashboard chart version | `string` | `"1.10.1"` | no |
| kubernetes\_helm\_externaldns\_chart\_name | Helm  External DNS chart name | `string` | `"stable/external-dns"` | no |
| kubernetes\_helm\_externaldns\_chart\_version | Helm  External DNS chart version | `string` | `"2.20.4"` | no |
| kubernetes\_helm\_ingress\_chart\_name | Helm Ingress controller Chart Name | `string` | `"stable/nginx-ingress"` | no |
| kubernetes\_helm\_ingress\_chart\_version | Helm Ingress Controller Chart Version | `string` | `"1.36.3"` | no |
| kubernetes\_helm\_keycloak\_chart\_name | Helm  Keycloak chart version | `string` | `"keycloak"` | no |
| kubernetes\_helm\_keycloak\_chart\_version | Helm Keycloak chart version | `string` | `"11.0.2"` | no |
| kubernetes\_helm\_kube-sm\_chart\_name | Helm Kube Static Metrics Chart Version | `string` | `"stable/kube-state-metrics"` | no |
| kubernetes\_helm\_kube-sm\_chart\_version | Helm Kube Static Metrics Chart Version | `string` | `"2.8.4"` | no |
| kubernetes\_helm\_metrics-server\_chart\_name | Helm  Metrics Server Chart Name | `string` | `"stable/metrics-server"` | no |
| kubernetes\_helm\_metrics-server\_chart\_version | Helm  Metrics Server Chart Version | `string` | `"2.11.1"` | no |
| kubernetes\_helm\_prometheusop\_chart\_name | Helm  Thanos chart version | `string` | `"stable/prometheus-operator"` | no |
| kubernetes\_helm\_prometheusop\_chart\_version | Helm  Prometheus operator chart version | `string` | `"8.13.8"` | no |
| kubernetes\_helm\_vault\_chart\_name | Helm  Thanos chart version | `string` | `"vault"` | no |
| kubernetes\_helm\_vault\_chart\_version | Helm Consul chart version | `string` | `"0.7.0"` | no |
| region | The AWS region | `any` | n/a | yes |
| role\_arn | The assumed role ARN | `any` | n/a | yes |
| root\_infra\_domain | Infrastructure root domain | `any` | n/a | yes |
| root\_public\_domain | Infrastructure public domain | `any` | n/a | yes |
| secret\_key | n/a | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| toString | n/a |

