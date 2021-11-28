## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12 |

## Providers

| Name | Version |
|------|---------|
| null | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| destination\_file\_path | Destination filename and path | `any` | n/a | yes |
| execution\_count | Destination filename and path | `number` | `1` | no |
| source\_template | Source template content | `any` | n/a | yes |
| template\_depends\_on | n/a | `any` | `[]` | no |
| template\_vars | Variables to fill the template | `map(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| rendered\_file | n/a |

