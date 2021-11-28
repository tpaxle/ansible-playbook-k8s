variable "ecr_repository" {
  description = "ECR Name"
  type = list(string)
}

variable "default_tags" {
  description = "Default Tags"
  type        = map(string)
}

