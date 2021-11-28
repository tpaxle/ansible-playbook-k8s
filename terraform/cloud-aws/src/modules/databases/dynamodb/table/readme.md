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
| attribute | Naming Convention Definition | `list(map(string))` | <pre>[<br>  {<br>    "name": "Path",<br>    "type": "S"<br>  },<br>  {<br>    "name": "Key",<br>    "type": "S"<br>  }<br>]</pre> | no |
| default\_tags | Default Tags | `map(string)` | n/a | yes |
| hash\_key | Hash key | `string` | `"Path"` | no |
| name | Dynamo DB Table Name | `any` | n/a | yes |
| range\_key | Hash key | `string` | `"Key"` | no |
| read\_capacity | Hash key | `string` | `"2"` | no |
| write\_capacity | Hash key | `string` | `"2"` | no |

## Outputs

| Name | Description |
|------|-------------|
| name | n/a |
| toString | n/a |

