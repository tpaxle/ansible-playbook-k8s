## Requirements

| Name | Version |
|------|---------|
| terraform | = 0.12.28 |
| terraform | >= 0.12 |
| aws | ~> 3.6 |

## Providers

No provider.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| default\_tags | Default Tags | `map(string)` | n/a | yes |
| ecr\_repository | Default Tags | `list(string)` | n/a | yes |
| region | Region where instances get created | `any` | n/a | yes |
| role\_arn | Role ARN for AWS provider | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| ecr | n/a |
| id | n/a |
| toString | n/a |

