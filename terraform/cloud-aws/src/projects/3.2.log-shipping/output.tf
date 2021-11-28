locals {
  options = <<TOSTRINGA
----------------------------------------------------
---3.2 Log config ----------------------------------
----------------------------------------------------
TOSTRINGA

}

output "toString" {
  value = local.options
}

