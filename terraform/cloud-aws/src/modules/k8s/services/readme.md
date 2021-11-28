## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12 |

## Providers

| Name | Version |
|------|---------|
| aws | n/a |
| helm | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| default\_tags | Default Tags | `map(string)` | n/a | yes |
| enable\_k8s\_security | Enable security module installation | `bool` | `false` | no |
| kubernetes\_helm\_certmanager\_chart\_name | Helm  Cert Manager chart version | `string` | `"cert-manager"` | no |
| kubernetes\_helm\_certmanager\_chart\_version | Helm Cert Manager chart version | `string` | `"1.0.1"` | no |
| kubernetes\_helm\_dashboard\_chart\_name | Helm Dashboard Chart Name | `string` | `"kubernetes-dashboard"` | no |
| kubernetes\_helm\_dashboard\_chart\_version | Helm Dashboard chart version | `string` | `"1.10.1"` | no |
| kubernetes\_helm\_externaldns\_chart\_name | Helm  External DNS chart name | `string` | `"external-dns"` | no |
| kubernetes\_helm\_externaldns\_chart\_version | Helm  External DNS chart version | `string` | `"2.20.4"` | no |
| kubernetes\_helm\_ingress\_chart\_name | Helm Ingress controller Chart Name | `string` | `"stable/nginx-ingress"` | no |
| kubernetes\_helm\_ingress\_chart\_version | Helm Ingress Controller Chart Version | `string` | `"1.36.3"` | no |
| kubernetes\_helm\_kube-sm\_chart\_name | Helm Kube Static Metrics Chart Version | `string` | `"kube-state-metrics"` | no |
| kubernetes\_helm\_kube-sm\_chart\_version | Helm Kube Static Metrics Chart Version | `string` | `"2.8.4"` | no |
| kubernetes\_helm\_metrics-server\_chart\_name | Helm  Metrics Server Chart Name | `string` | `"metrics-server"` | no |
| kubernetes\_helm\_metrics-server\_chart\_version | Helm  Metrics Server Chart Version | `string` | `"2.11.1"` | no |
| login\_depends\_on | n/a | `any` | `[]` | no |
| region | Region where instances kms will be used | `any` | n/a | yes |
| root\_infra\_domain | Infrastructure domain | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| certmanager | ######################### ###   Cert Manager   #### ######################### |
| external\_dns | n/a |
| toString | n/a |

