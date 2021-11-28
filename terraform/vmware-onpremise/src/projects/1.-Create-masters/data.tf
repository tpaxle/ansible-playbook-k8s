data "vsphere_datacenter" "dc" {
  name = var.dc_name
}

data "vsphere_datacenter" "dc2" {
  name = var.dc2_name
}


data "vsphere_datastore" "datastore" {
  name          = var.datastorage_name
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_datastore" "datastore2" {
  name          = var.datastorage2_name
  datacenter_id = data.vsphere_datacenter.dc2.id
}

data "vsphere_compute_cluster" "cluster" {
  name          = var.dc_cluster_name
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_compute_cluster" "cluster2" {
  name          = var.dc_cluster2_name
  datacenter_id = "${data.vsphere_datacenter.dc2.id}"
}

data "vsphere_resource_pool" "pool" {
  name          = "cluster1/Resources"
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_network" "network" {
  name          = "VM Network"
  datacenter_id = data.vsphere_datacenter.dc.id
}


data "vsphere_datacenter" "dc_template" {
  name = var.dc_template_name
}

data "vsphere_virtual_machine" "template" {
  name          = var.template_name
  datacenter_id = "${data.vsphere_datacenter.dc_template.id}"
}