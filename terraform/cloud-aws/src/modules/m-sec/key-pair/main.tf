resource "aws_key_pair" "key" {
  key_name   = var.name
  public_key = fileexists(var.path) ? file(var.path) : file(trimprefix(var.path, "../"))
}

