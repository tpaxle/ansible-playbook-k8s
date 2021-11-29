locals {
  options = <<MANAGEMENT
----------------------------------------------------
---VM-----------------------------------------------
----------------------------------------------------
  VM name ${vsphere_virtual_machine.vm.id}
MANAGEMENT
}

output "toString" {
  value = local.options
}

output "id" {
  value = vsphere_virtual_machine.vm.id
}
