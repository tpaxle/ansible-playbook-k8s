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
| default\_tags | Default Tags | `map(string)` | n/a | yes |
| es\_access\_cidr | CIDR | `list(string)` | n/a | yes |
| from\_port | From Port | `any` | n/a | yes |
| object\_sufix | The VPC ID | `any` | n/a | yes |
| protocol | To Port | `string` | `"tcp"` | no |
| to\_port | To Port | `any` | n/a | yes |
| vpc\_id | The VPC ID | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| sg\_id | n/a |

