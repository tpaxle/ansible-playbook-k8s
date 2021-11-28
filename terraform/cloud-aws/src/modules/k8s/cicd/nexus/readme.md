## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| helm | n/a |
| template | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| default\_tags | Default Tags | `map(string)` | n/a | yes |
| enable\_cicd | Enable cicd module installation | `bool` | `false` | no |
| kubernetes\_helm\_nexus\_chart\_name | Helm  Nexus chart name | `string` | `"sonatype-nexus"` | no |
| kubernetes\_helm\_nexus\_chart\_version | Helm  Nexus operator chart version | `string` | `"2.8.0"` | no |
| observability\_depends\_on | n/a | `any` | `[]` | no |
| root\_infra\_domain | Infrastructure domain | `any` | n/a | yes |

## Outputs

No output.

