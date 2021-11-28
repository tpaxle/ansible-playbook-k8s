output "ecr" {
  value = module.ecr.repo_url
}

output "id" {
  value = module.ecr.registry_id
}

locals {
  options = <<TOSTRINGA
----------------------------------------------------
---1.3 ECR Configuration----------------------------
----------------------------------------------------
ECR Created: (${module.ecr.registry_id[0]})
  URL:      ${module.ecr.repo_url[0]}
TOSTRINGA

}

output "toString" {
  value = local.options
}

