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
| aws\_azs | ############################################################################## #### NGW OPTIONS ############################################################# ############################################################################## | `list(string)` | n/a | yes |
| basenameeip | n/a | `any` | n/a | yes |
| basenamengw | n/a | `any` | n/a | yes |
| default\_tags | Default Tags | `map(string)` | n/a | yes |
| object\_sequence | Sequence id | `any` | n/a | yes |
| subnets\_id | n/a | `list(string)` | n/a | yes |
| zones | n/a | `map(string)` | <pre>{<br>  "0": "a",<br>  "1": "b",<br>  "2": "c"<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| vpc\_ngw\_id | n/a |
| vpc\_ngw\_ip | n/a |

