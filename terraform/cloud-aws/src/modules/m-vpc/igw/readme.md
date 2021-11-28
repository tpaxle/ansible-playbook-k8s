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
| basenameigw | n/a | `any` | n/a | yes |
| default\_tags | Default Tags | `map(string)` | n/a | yes |
| object\_sequence | Sequence id | `any` | n/a | yes |
| vpc\_id | The VPC ID | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| vpc\_igw\_id | n/a |

