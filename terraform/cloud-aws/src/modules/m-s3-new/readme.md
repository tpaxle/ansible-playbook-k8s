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
| acl | n/a | `string` | `"private"` | no |
| basenamebucket | n/a | `any` | n/a | yes |
| default\_tags | Default Tags | `map(string)` | n/a | yes |
| object\_id | s3-lb | `any` | n/a | yes |
| object\_sequence | Sequence id | `any` | n/a | yes |
| path | n/a | `any` | n/a | yes |
| region | n/a | `any` | n/a | yes |
| tags | Bucket tags | `map(string)` | n/a | yes |
| template\_vars | template vars | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| bucket | n/a |
| id | n/a |

