data "vsphere_datacenter" "dc" {
  name = var.dc_name
}

data "vsphere_datastore" "datastore" {
  name          = var.dc_name
  datacenter_id = data.vsphere_datacenter.dc.id
}