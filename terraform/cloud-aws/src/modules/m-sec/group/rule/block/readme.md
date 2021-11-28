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
| description | Security Group rule | `any` | n/a | yes |
| es\_access\_cidr | CIDR | `list(string)` | n/a | yes |
| from\_port | From Port | `any` | n/a | yes |
| protocol | To Port | `string` | `"tcp"` | no |
| rule\_type | Type of the rule | `string` | `"ingress"` | no |
| security\_group\_id | Security Group id | `any` | n/a | yes |
| to\_port | To Port | `any` | n/a | yes |

## Outputs

No output.

