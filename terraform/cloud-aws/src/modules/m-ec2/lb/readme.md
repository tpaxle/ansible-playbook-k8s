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
| basenamenlb | n/a | `any` | n/a | yes |
| bucketname | n/a | `any` | n/a | yes |
| certificatearn | n/a | `any` | n/a | yes |
| certpolicy | n/a | `string` | `"ELBSecurityPolicy-2016-08"` | no |
| default\_tags | Default Tags | `map(string)` | n/a | yes |
| object\_sequence | Sequence id | `any` | n/a | yes |
| securitygroups | n/a | `list(string)` | n/a | yes |
| subnets | n/a | `list(string)` | n/a | yes |
| vpcid | ID VPc | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| arn | n/a |
| arn\_suffix | n/a |
| dns\_name | n/a |
| id | n/a |
| zone\_id | n/a |

