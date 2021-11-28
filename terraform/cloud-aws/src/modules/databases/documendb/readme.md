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
| aws\_azs | Availability Zones | `list(string)` | n/a | yes |
| baserdsname | n/a | `any` | n/a | yes |
| database\_name | database name | `string` | `""` | no |
| dbclustername | Cluster DB name | `string` | `""` | no |
| default\_tags | Default Tags | `map(string)` | n/a | yes |
| deletion\_protection | Delete protection | `string` | `"false"` | no |
| engine | The name of the database engine to be used for this DB cluster. | `string` | `"docdb"` | no |
| instance\_type | Instnce type | `string` | `"db.r4.large"` | no |
| kms\_key\_id | KMS ID Data | `bool` | `true` | no |
| master\_password | Password for the master database user | `string` | `"changeme"` | no |
| master\_username | Username for the master database user | `string` | `"master"` | no |
| object\_sequence | Sequence id | `any` | n/a | yes |
| rds\_preferred\_maintenance\_window | Maintenance Windows | `string` | `"wed:03:00-wed:04:00"` | no |
| storage\_encrypted | Encryption Data | `bool` | `true` | no |
| subnetgroupname | Subnet group name | `string` | `""` | no |
| subnets\_ids | Availability Zones | `list(string)` | n/a | yes |
| vpc\_security\_group\_ids | Security Groups | `list(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| cluster\_identifier | n/a |
| endpoint\_reader\_endpoint | n/a |
| endpoint\_static\_endpoint | n/a |

