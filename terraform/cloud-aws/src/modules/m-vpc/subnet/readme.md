## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12 |

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| aws\_azs | List of availability zones to use | `list(string)` | n/a | yes |
| basenamesnt | n/a | `any` | n/a | yes |
| default\_tags | Default Tags | `map(string)` | n/a | yes |
| list\_subnets | n/a | `list(string)` | n/a | yes |
| map\_public\_ip\_on\_launch | n/a | `bool` | `true` | no |
| object\_sequence | Sequence id | `string` | n/a | yes |
| public\_subnets\_tags | n/a | `map(string)` | n/a | yes |
| subnet\_sufix | Sufix subnet | `any` | n/a | yes |
| vpc\_id | The VPC ID | `any` | n/a | yes |
| zones | n/a | `map(string)` | <pre>{<br>  "0": "a",<br>  "1": "b",<br>  "2": "c"<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| cidr\_block | n/a |
| subnets\_ids | n/a |

