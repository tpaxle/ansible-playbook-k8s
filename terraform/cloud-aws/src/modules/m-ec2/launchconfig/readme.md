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
| associate\_public\_ip\_address | associate public ip addres | `bool` | `false` | no |
| iam\_instance\_profile | IAM Profile | `any` | n/a | yes |
| image\_id | EC2 image id | `any` | n/a | yes |
| instance\_type | EC2 instance type id | `any` | n/a | yes |
| key\_name | Key name | `any` | n/a | yes |
| name\_prefix | Key name | `any` | n/a | yes |
| security\_groups | Security Groups id | `list(string)` | n/a | yes |
| user\_data\_base64 | Key name | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| id | n/a |

