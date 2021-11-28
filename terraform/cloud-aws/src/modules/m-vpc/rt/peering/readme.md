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
| destination\_route | CIDR block for the world | `any` | n/a | yes |
| gw\_id | The app peering gw ID | `any` | n/a | yes |
| route\_tables | List of route Tables where the new routes are inserted. | `list(string)` | n/a | yes |

## Outputs

No output.

