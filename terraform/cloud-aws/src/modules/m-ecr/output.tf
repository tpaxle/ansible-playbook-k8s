output "repo_url" {
  value = aws_ecr_repository.repo.*.repository_url
}

output "registry_id" {
  value = aws_ecr_repository.repo.*.registry_id
}

