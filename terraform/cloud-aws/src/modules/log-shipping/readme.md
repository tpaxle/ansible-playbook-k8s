## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| archive | n/a |
| aws | n/a |
| template | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| aws\_account\_id | AWS account id | `any` | n/a | yes |
| baseiampolicy | n/a | `any` | n/a | yes |
| baseiamrole | n/a | `any` | n/a | yes |
| basenamecld | n/a | `any` | n/a | yes |
| basenameclr | n/a | `any` | n/a | yes |
| basenamecwf | n/a | `any` | n/a | yes |
| basenamekfd | n/a | `any` | n/a | yes |
| basenamelambdafunction | n/a | `any` | n/a | yes |
| basenamelogs | n/a | `any` | n/a | yes |
| cloudwatch\_log\_groups | n/a | `list` | `[]` | no |
| default\_tags | Default Tags | `map` | n/a | yes |
| enable\_cloudtrail | Create cloudtrail event flag | `bool` | `false` | no |
| region | The AWS region | `any` | n/a | yes |
| s3\_cloudrail\_id | Ide S3 bucket | `any` | n/a | yes |
| s3\_logs\_arn | ID S3 bucket logs | `any` | n/a | yes |

## Outputs

No output.

