resource "vsphere_virtual_machine" "vm" {
  name             = var.vm_name
  resource_pool_id = var.resource_pool_id
  datastore_id     = var. datacenter_id

  num_cpus = var.vm_cpu
  memory   = var.vm_ram
  guest_id = var.guest_id

  scsi_type = var.scsi_type

  firmware = var.vm_firmware
  network_interface {
    network_id   = var.network_id
    adapter_type = var.adapter_type
  }

  disk {
    label            = "disk0"
    size             = var.disk_size
    eagerly_scrub    = var.disk_eagerly
    thin_provisioned = var.thin_provisioned
  }

  clone {
    template_uuid = var.vm_template_uuid

    customize {
      dns_server_list = var.vm_dns_servers
      linux_options {
        host_name = var.vm_hostname
        domain    = var.vm_domain
      }

      network_interface {
        ipv4_address = var.vm_ip
        ipv4_netmask = var.vm_netmask
      }

      ipv4_gateway = var.vm_gw
    }
  }
}