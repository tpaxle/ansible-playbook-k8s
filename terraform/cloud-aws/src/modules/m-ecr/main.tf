resource "aws_ecr_repository" "repo" {
  count = length(var.ecr_repository)
  name                 = var.ecr_repository[count.index]
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
  tags = merge(
    {
      "Name" = var.ecr_repository[count.index]
    },
    var.default_tags,
  )
}

