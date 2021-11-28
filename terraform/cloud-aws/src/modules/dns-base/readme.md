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
| basenamedns | n/a | `any` | n/a | yes |
| default\_tags | Default Tags | `map(string)` | n/a | yes |
| domain\_prefix | For examole the environment name e.g. dev, prod | `any` | n/a | yes |
| object\_sequence | Sequence id | `any` | n/a | yes |
| root\_domain\_name | The value of the default domain name | `any` | n/a | yes |
| tag\_infra\_unit | tag infra unit | `any` | n/a | yes |
| tag\_zone\_type | Tag zone type | `any` | n/a | yes |
| vpc\_id | VPC ID to assign DNS Zone | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| subdomain\_name | n/a |
| subdomain\_zone\_id | n/a |

