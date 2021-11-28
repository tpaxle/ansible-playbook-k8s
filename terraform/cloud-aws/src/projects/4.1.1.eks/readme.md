## Requirements

| Name | Version |
|------|---------|
| terraform | = 0.12.28 |
| terraform | >= 0.12 |
| aws | ~> 3.6 |

## Providers

| Name | Version |
|------|---------|
| aws | ~> 3.6 |
| kubernetes | n/a |
| template | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| default\_tags | Default Tags | `map(string)` | n/a | yes |
| eks\_monitoring\_worker\_instance\_type | EKS Monitoring Worker instance type | `string` | `"t2.2xlarge"` | no |
| eks\_other\_access\_list | n/a | `list` | `[]` | no |
| eks\_version | EKS Version | `string` | `"1.15"` | no |
| eks\_worker\_desired | EKS Worker ASG desired count | `string` | `"3"` | no |
| eks\_worker\_instance\_type | EKS Worker instance type | `string` | `"t2.2xlarge"` | no |
| eks\_worker\_max | EKS Worker ASG max count | `string` | `"11"` | no |
| eks\_worker\_min | EKS Worker ASG min count | `string` | `"1"` | no |
| env\_folder\_name | folder name in the env\_path with environment files | `any` | n/a | yes |
| envs\_path | Environment relative folder path | `string` | `"../../../envs"` | no |
| naming\_convention\_definition | Naming Convention Definition | `map(string)` | `{}` | no |
| region | The AWS region | `any` | n/a | yes |
| role\_arn | The assumed role ARN | `any` | n/a | yes |
| root\_infra\_domain | Infrastructure root domain | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| kubeconfig | n/a |
| toString | n/a |

