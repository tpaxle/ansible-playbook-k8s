###############################################################################
##### COMMON VARIABLES ########################################################
###############################################################################

variable "default_tags" {
  description = "Default Tags"
  type        = map(string)
}

variable "vm_name" {
  description = "New VM Name"
}

variable "resource_pool_id" {
  description = "New VM resource_pool_id"
}
variable "datacenter_id" {
  description = "New VM datacenter_id"
}


variable "vm_cpu" {
  description = "New VM vm_cpu"
}

variable "vm_ram" {
  description = "New VM vm_ram"
}

variable "guest_id" {
  description = "New VM guest_id"
}

variable "scsi_type" {
  description = "New VM guest_id"
}

variable "disk_size" {
  description = "New VM disk_size"
}

variable "disk_eagerly" {
  description = "New VM disk_eagerly"
}

variable "thin_provisioned" {
  description = "New VM thin_provisioned"
}

variable "vm_template_uuid" {
  description = "New VM vm_template_uuid"
}
variable "vm_hostname" {
  description = "New VM vm_hostname"
}

variable "vm_domain" {
  description = "New VM vm_domain"
}

variable "vm_ip" {
  description = "New VM vm_ip"
}

variable "vm_netmask" {
  description = "New VM vm_netmask"
}

variable "vm_gw" {
  description = "New VM vm_netmask"
}
