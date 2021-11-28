####################################################################################
######################################## Dc ########################################
####################################################################################

data "vsphere_datacenter" "dc1" {
  name = var.dc_name
}

data "vsphere_datacenter" "dc2" {
  name = var.dc2_name
}


####################################################################################
############################## Dtatastorage  #######################################
####################################################################################

data "vsphere_datastore" "datastore1_1" {
  name          = var.datastorage_name
  datacenter_id = data.vsphere_datacenter.dc1.id
}

data "vsphere_datastore" "datastore1_2" {
  name          = var.datastorage2_name
  datacenter_id = data.vsphere_datacenter.dc1.id
}

data "vsphere_datastore" "datastore2_1" {
  name          = var.datastorage_name
  datacenter_id = data.vsphere_datacenter.dc2.id
}

data "vsphere_datastore" "datastore2_2" {
  name          = var.datastorage2_name
  datacenter_id = data.vsphere_datacenter.dc2.id
}



####################################################################################
############################## Clusters #### #######################################
####################################################################################


data "vsphere_compute_cluster" "cluster1" {
  name          = var.dc_cluster_name
  datacenter_id = "${data.vsphere_datacenter.dc1.id}"
}

data "vsphere_compute_cluster" "cluster2" {
  name          = var.dc_cluster2_name
  datacenter_id = "${data.vsphere_datacenter.dc2.id}"
}

data "vsphere_resource_pool" "pool" {
  name          = "cluster1/Resources"
  datacenter_id = data.vsphere_datacenter.dc.id
}


####################################################################################
############################## Metworks #### #######################################
####################################################################################

data "vsphere_network" "network" {
  name          = "VM Network"
  datacenter_id = data.vsphere_datacenter.dc.id
}

####################################################################################
############################## Templates ###########################################
####################################################################################


data "vsphere_datacenter" "dc_template" {
  name = var.dc_template_name
}

data "vsphere_virtual_machine" "template" {
  name          = var.template_name
  datacenter_id = "${data.vsphere_datacenter.dc_template.id}"
}