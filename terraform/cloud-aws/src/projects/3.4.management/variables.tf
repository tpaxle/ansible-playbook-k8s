###############################################################################
##### COMMON VARIABLES ########################################################
###############################################################################

variable "default_tags" {
  description = "Default Tags"
  type        = map(string)
}



variable "region" {
  description = "The AWS region"
}
variable "mgmt_pfsense_image_id" {
  description = "image id"
}

variable "mgmt_pfsense_dns_ip" {
  description = "DHCP DNS IP."
}

#####

variable "root_infra_domain" {
  description = "Infrastructure domain"
}

variable "root_public_domain" {
  description = "Infrastructure public domain"
}

variable "az_dns_vpn" {
  description = "Domain name vpn"
}

variable "subnet_vpn_zone_id" {
  description = "Zone id used for the subnet where network interface will be attached"
  default = "a"
}

variable "env_folder_name" {
  description = "folder name in the env_path with environment files"
}