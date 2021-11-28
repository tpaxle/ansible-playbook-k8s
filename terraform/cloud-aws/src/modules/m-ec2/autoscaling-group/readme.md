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
| cluster\_id | Desire capacity | `any` | n/a | yes |
| desired\_capacity | Desire capacity | `string` | `"1"` | no |
| launch\_config\_id | Desire capacity | `any` | n/a | yes |
| max\_size | Desire capacity | `string` | `"2"` | no |
| min\_size | Desire capacity | `string` | `"0"` | no |
| name | Desire capacity | `string` | `"0"` | no |
| subnet\_ids | Desire capacity | `list(string)` | n/a | yes |

## Outputs

No output.

