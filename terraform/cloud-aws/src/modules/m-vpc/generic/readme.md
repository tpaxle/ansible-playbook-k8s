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
| basenamevpc | n/a | `any` | n/a | yes |
| default\_tags | Default Tags | `map(string)` | n/a | yes |
| enable\_dns\_hostnames | A boolean flag to enable/disable DNS hostnames in the VPC Defaults false. | `bool` | `true` | no |
| enable\_dns\_support | A boolean flag to enable/disable DNS support in the VPC. Defaults true. | `bool` | `true` | no |
| object\_sequence | Sequence id | `any` | n/a | yes |
| vpc\_cidr\_block | VPC CIDR block | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| arn | n/a |
| vpc\_cidr | n/a |
| vpc\_id | n/a |

