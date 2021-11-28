## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12 |

## Providers

| Name | Version |
|------|---------|
| aws | n/a |
| template | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| az\_dns\_name | Dns domain zone in azure | `any` | n/a | yes |
| az\_dns\_vpn | Domain name vpn | `any` | n/a | yes |
| az\_rg\_name | Resource group where azure dns is | `any` | n/a | yes |
| default\_tags | Default Tags | `map(string)` | n/a | yes |
| env\_folder\_name | folder name in the env\_path with environment files | `any` | n/a | yes |
| envs\_path | Environment relative folder path | `string` | `"../../../envs"` | no |
| mgmt\_pfsense\_dns\_ip | DHCP DNS IP. | `any` | n/a | yes |
| mgmt\_pfsense\_image\_id | image id | `any` | n/a | yes |
| naming\_convention\_definition | Naming Convention Definition | `map(string)` | `{}` | no |
| region | The AWS region | `any` | n/a | yes |
| role\_arn | The assumed role ARN | `any` | n/a | yes |
| root\_infra\_domain | Infrastructure domain | `any` | n/a | yes |
| root\_public\_domain | Infrastructure public domain | `any` | n/a | yes |
| sg\_mgmt\_ssh\_object\_sequence | Security Group ssh object sequence | `any` | n/a | yes |
| subnet\_zone\_id | Zone id used for the subnet where network interface will be attached | `string` | `"a"` | no |

## Outputs

| Name | Description |
|------|-------------|
| openvpn | n/a |
| toString | n/a |

