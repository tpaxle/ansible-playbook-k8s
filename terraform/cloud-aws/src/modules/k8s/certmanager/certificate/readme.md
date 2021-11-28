## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |
| null | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| certficate\_name | n/a | `any` | n/a | yes |
| commonname | n/a | `any` | n/a | yes |
| default\_tags | Default Tags | `map(string)` | n/a | yes |
| enable\_k8s\_security | Enable security module installation | `bool` | `true` | no |
| issuername | n/a | `string` | `"vault-issuer"` | no |
| kubernetes\_helm\_vault\_chart\_name | Helm  Thanos chart version | `string` | `"vault"` | no |
| kubernetes\_helm\_vault\_chart\_version | Helm Consul chart version | `string` | `"0.7.0"` | no |
| login\_depends\_on | n/a | `any` | `[]` | no |
| naming\_convention\_definition | Naming Convention Definition | `map(string)` | `{}` | no |
| security\_depends\_on | n/a | `any` | `[]` | no |

## Outputs

No output.

