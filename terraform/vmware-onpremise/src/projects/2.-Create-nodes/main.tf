module "node_server_1"{
    source = "../../modules/vm-clone"

    vm_name             = "worker-node-1"
    vm_cpu              = var.master_cpu
    vm_ram              = var.master_ram
    vm_hostname         = "worker-node-1"
    vm_domain           = var.domain
    vm_ip               = "10.0.0.34"
    vm_netmask          = "24"
    vm_gw               = "10.0.0.101"


    resource_pool_id    = "${data.vsphere_compute_cluster.cluster2.resource_pool_id}"
    datacenter_id       = "${data.vsphere_datastore.datastore2_1.id}"
    guest_id            = "${data.vsphere_virtual_machine.template.guest_id}"
    scsi_type           = "${data.vsphere_virtual_machine.template.scsi_type}"
    vm_template_uuid    = "${data.vsphere_virtual_machine.template.id}"
    
    adapter_type        = "${data.vsphere_virtual_machine.template.network_interface_types[0]}"
    network_id          = "${data.vsphere_network.network_2.id}"

    disk_size           = "${data.vsphere_virtual_machine.template.disks.0.size}"
    disk_eagerly        = "${data.vsphere_virtual_machine.template.disks.0.eagerly_scrub}"
    thin_provisioned    = "${data.vsphere_virtual_machine.template.disks.0.thin_provisioned}"

    default_tags	= var.default_tags
}

module "node_server_2"{
    source = "../../modules/vm-clone"

    vm_name             = "worker-node-2"
    vm_cpu              = var.master_cpu
    vm_ram              = var.master_ram
    vm_hostname         = "worker-node-2"
    vm_domain           = var.domain
    vm_ip               = "10.0.0.35"
    vm_netmask          = "24"
    vm_gw               = "10.0.0.101"


    resource_pool_id    = "${data.vsphere_compute_cluster.cluster1.resource_pool_id}"
    datacenter_id       = "${data.vsphere_datastore.datastore1_1.id}"
    guest_id            = "${data.vsphere_virtual_machine.template.guest_id}"
    scsi_type           = "${data.vsphere_virtual_machine.template.scsi_type}"
    vm_template_uuid    = "${data.vsphere_virtual_machine.template.id}"
    
    adapter_type        = "${data.vsphere_virtual_machine.template.network_interface_types[0]}"
    network_id          = "${data.vsphere_network.network_2.id}"

    disk_size           = "${data.vsphere_virtual_machine.template.disks.0.size}"
    disk_eagerly        = "${data.vsphere_virtual_machine.template.disks.0.eagerly_scrub}"
    thin_provisioned    = "${data.vsphere_virtual_machine.template.disks.0.thin_provisioned}"

    default_tags	= var.default_tags
}

module "node_server_3"{
    source = "../../modules/vm-clone"

    vm_name             = "worker-node-3"
    vm_cpu              = var.master_cpu
    vm_ram              = var.master_ram
    vm_hostname         = "worker-node-3"
    vm_domain           = var.domain
    vm_ip               = "10.0.0.36"
    vm_netmask          = "24"
    vm_gw               = "10.0.0.101"


    resource_pool_id    = "${data.vsphere_compute_cluster.cluster1.resource_pool_id}"
    datacenter_id       = "${data.vsphere_datastore.datastore1_2.id}"
    guest_id            = "${data.vsphere_virtual_machine.template.guest_id}"
    scsi_type           = "${data.vsphere_virtual_machine.template.scsi_type}"
    vm_template_uuid    = "${data.vsphere_virtual_machine.template.id}"
    
    adapter_type        = "${data.vsphere_virtual_machine.template.network_interface_types[0]}"
    network_id          = "${data.vsphere_network.network_2.id}"

    disk_size           = "${data.vsphere_virtual_machine.template.disks.0.size}"
    disk_eagerly        = "${data.vsphere_virtual_machine.template.disks.0.eagerly_scrub}"
    thin_provisioned    = "${data.vsphere_virtual_machine.template.disks.0.thin_provisioned}"

    default_tags	= var.default_tags
}
