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
| baserdsname | n/a | `any` | n/a | yes |
| cluster\_id | Cluster id | `any` | n/a | yes |
| database\_name | Identifier for the cluster which will be used in database\_name, alphanumeric only | `any` | n/a | yes |
| engine | The name of the database engine to be used for this DB cluster. | `string` | `"aurora-postgresql"` | no |
| engine\_version | The database engine version | `string` | `"9.6.12"` | no |
| instance\_type | Instnce type | `string` | `"db.r5.large"` | no |
| object\_sequence | Sequence id | `any` | n/a | yes |
| publicaccesible | n/a | `bool` | `false` | no |

## Outputs

No output.

