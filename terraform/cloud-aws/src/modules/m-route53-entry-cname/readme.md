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
| extra | n/a | `string` | `"test"` | no |
| new\_name | Route53 zone ID | `any` | n/a | yes |
| records | Record name to point cname | `any` | n/a | yes |
| zone\_id | Route53 zone ID | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| fqdn | n/a |

