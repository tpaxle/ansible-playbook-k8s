module "master_server_1"{
    source = "../../modules/vm-clone"

    vm_name             = "master-node-1"
    vm_cpu              = var.master_cpu
    vm_ram              = var.master_ram
    vm_hostname         = "master-node-1"
    vm_domain           = var.domain
    vm_ip               = "10.0.0.31"
    vm_netmask          = "255.255.255.0"
    vm_gw               = "10.0.0.101"


    resource_pool_id    = "${data.vsphere_compute_cluster.cluster.resource_pool_id}"
    datacenter_id       = "${data.vsphere_datastore.datastore.id}"
    guest_id            = "${data.vsphere_virtual_machine.template.guest_id}"
    scsi_type           = "${data.vsphere_virtual_machine.template.scsi_type}"
    vm_template_uuid    = "${data.vsphere_virtual_machine.template.id}"
    
    adapter_type        = "${data.vsphere_virtual_machine.template.network_interface_types[0]}"
    network_id          = "${data.vsphere_network.network.id}"

    disk_size           = "${data.vsphere_virtual_machine.template.disks.0.size}"
    disk_eagerly        = "${data.vsphere_virtual_machine.template.disks.0.eagerly_scrub}"
    thin_provisioned    = "${data.vsphere_virtual_machine.template.disks.0.thin_provisioned}"

    default_tags	= var.default_tags
}
