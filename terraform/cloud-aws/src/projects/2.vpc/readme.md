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

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| aws\_azs | List of availability zones to use | `list(string)` | n/a | yes |
| default\_tags | Default Tags | `map(string)` | n/a | yes |
| external\_global\_cidr | CIDR block for the world | `string` | `"0.0.0.0/0"` | no |
| naming\_convention\_definition | Naming Convention Definition | `map(string)` | `{}` | no |
| private\_rt\_tags\_eks | n/a | `map(string)` | n/a | yes |
| private\_rt\_tags\_kfk | n/a | `map(string)` | n/a | yes |
| private\_rt\_tags\_rds | n/a | `map(string)` | n/a | yes |
| private\_rt\_tags\_ris | n/a | `map(string)` | n/a | yes |
| private\_subnets\_eks | n/a | `list(string)` | n/a | yes |
| private\_subnets\_kfk | n/a | `list(string)` | n/a | yes |
| private\_subnets\_rds | n/a | `list(string)` | n/a | yes |
| private\_subnets\_ris | n/a | `list(string)` | n/a | yes |
| private\_subnets\_tags\_eks | n/a | `map(string)` | n/a | yes |
| private\_subnets\_tags\_kfk | n/a | `map(string)` | n/a | yes |
| private\_subnets\_tags\_rds | n/a | `map(string)` | n/a | yes |
| private\_subnets\_tags\_ris | n/a | `map(string)` | n/a | yes |
| public\_rt\_tags | n/a | `map(string)` | n/a | yes |
| public\_subnets | n/a | `list(string)` | n/a | yes |
| public\_subnets\_tags | n/a | `map(string)` | n/a | yes |
| region | The AWS region | `any` | n/a | yes |
| role\_arn | The assumed AWS role ARN | `any` | n/a | yes |
| root\_public\_domain | Infrastructure public domain | `any` | n/a | yes |
| vpc\_cidr\_block | VPC CIDR block | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| toString | n/a |

