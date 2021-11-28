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
| default\_tags | Default Tags | `map(string)` | n/a | yes |
| ecr\_repository | ECR Name | `list(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| registry\_id | n/a |
| repo\_url | n/a |

