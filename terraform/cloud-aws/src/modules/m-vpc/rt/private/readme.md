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
| external\_global\_cidr | CIDR block for the world | `string` | `"0.0.0.0/0"` | no |
| gw\_id | The app nat gw ID | `list(string)` | n/a | yes |
| route\_tables | List of route Tables | `list(string)` | n/a | yes |

## Outputs

No output.

