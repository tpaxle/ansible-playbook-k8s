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
| basenamertb | n/a | `any` | n/a | yes |
| default\_tags | Default Tags | `map(string)` | n/a | yes |
| igw\_connections | IGW id | `list` | `[]` | no |
| natgw\_connections | NAT GW id | `list` | `[]` | no |
| object\_sequence | Sequence id | `string` | n/a | yes |
| peering\_connections | List of peering ID connections | `list(map(string))` | `[]` | no |
| public\_rt\_tags | n/a | `map(string)` | n/a | yes |
| subnets\_id | List of Subnets ids | `list(string)` | n/a | yes |
| vpc\_id | The VPC ID | `any` | n/a | yes |
| zones | n/a | `map(string)` | <pre>{<br>  "0": "a",<br>  "1": "b",<br>  "2": "c"<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| route\_tables | n/a |

