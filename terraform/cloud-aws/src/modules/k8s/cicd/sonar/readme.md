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
| kubernetes\_helm\_sonar\_chart\_name | Helm  Sonar chart name | `string` | `"stable/prometheus-operator"` | no |
| kubernetes\_helm\_sonar\_chart\_version | Helm  Sonar operator chart version | `string` | `"4.0.1"` | no |
| observability\_depends\_on | n/a | `any` | `[]` | no |
| root\_infra\_domain | Infrastructure domain | `any` | n/a | yes |

## Outputs

No output.

