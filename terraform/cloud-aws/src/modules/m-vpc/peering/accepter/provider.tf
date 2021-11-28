provider "aws" {
  region = var.region

  alias = "shared"

  assume_role {
    role_arn = var.shared_role_arn
  }
}
