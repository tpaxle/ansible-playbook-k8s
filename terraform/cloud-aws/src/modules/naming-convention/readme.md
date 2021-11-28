## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12 |

## Providers

No provider.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| application | n/a | `string` | `"globil"` | no |
| entity | Entity Name | `string` | `"sdi"` | no |
| environment | Environment | `string` | `"s1"` | no |
| geo\_region | n/a | `string` | `"ald"` | no |
| naming\_convention\_definition | Map the following variables defined (basenamebucket, baseiamrole, basekmskey, baserdsname, basekfkname, basenamevpc, basenamecrd, basenamenlb, basenamecrt, basenameigw, basenamengw, basenameeip, basenamesnt, basenamertb, basenamedns, baseiampolicy, basenameclr, basenamecwf, basenamecld, basenamekfd, basenamelambdafunction, basenamelogs and basenamesgr) | `map` | `{}` | no |
| region | Region to base all of our commands on | `any` | n/a | yes |
| role\_arn | n/a | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| baseiampolicy | n/a |
| baseiamrole | n/a |
| basekfkname | n/a |
| basekmskey | n/a |
| basenamebucket | n/a |
| basenamecld | n/a |
| basenameclr | n/a |
| basenamecrd | n/a |
| basenamecrt | n/a |
| basenamecwf | n/a |
| basenamedns | n/a |
| basenameeip | n/a |
| basenameigw | n/a |
| basenamekfd | n/a |
| basenamelambdafunction | n/a |
| basenamelogs | n/a |
| basenamengw | n/a |
| basenamenlb | n/a |
| basenamertb | n/a |
| basenamesgr | n/a |
| basenamesnt | n/a |
| basenamevpc | n/a |
| baserdsname | n/a |
| default\_object\_sequence\_number | n/a |
| ris\_object\_sequence | n/a |

