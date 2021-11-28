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
| default\_tags | Default Tags | `map(string)` | n/a | yes |
| enable\_k8s\_istio | Enable istio module installation | `bool` | `false` | no |
| enable\_k8s\_keycloak | Enable keycloak installation | `bool` | `false` | no |
| enable\_k8s\_security | Enable security module installation | `bool` | `false` | no |
| kubernetes\_helm\_keycloak\_chart\_name | Helm  Keycloak chart version | `string` | `"keycloak"` | no |
| kubernetes\_helm\_keycloak\_chart\_version | Helm Keycloak chart version | `string` | `"9.1.0"` | no |
| kubernetes\_helm\_vault\_chart\_name | Helm  Thanos chart version | `string` | `"vault"` | no |
| kubernetes\_helm\_vault\_chart\_version | Helm Consul chart version | `string` | `"0.7.0"` | no |
| naming\_convention\_definition | Naming Convention Definition | `map(string)` | `{}` | no |
| region | The AWS region | `any` | n/a | yes |
| role\_arn | The assumed role ARN | `any` | n/a | yes |
| root\_infra\_domain | Infrastructure root domain | `any` | n/a | yes |
| vault\_enable\_public | Enable public load balancer | `string` | `"0"` | no |
| vault\_ip\_access | Ip whitelist | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| toString | n/a |

