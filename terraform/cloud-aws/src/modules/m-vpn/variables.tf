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

variable "envs_path" {
  description = "Environment relative folder path"
  default     = "../../../envs"
}

variable "mgmt_pfsense_dns_ip" {
  description = "DHCP DNS IP."
}

variable "mgmt_pfsense_image_id" {
  description = "image id"
}

variable "az_dns_vpn" {
  description = "Domain name vpn"
}

variable "root_infra_domain" {
  description = "Infrastructure domain"
}

variable "root_public_domain" {
  description = "Infrastructure public domain"
}



variable "sg_mgmt_ssh_object_sequence"{
  description = "Security Group ssh object sequence"
}
variable "naming_convention_definition" {
  description = "Naming Convention Definition"
  type        = map(string)
  default     = {}
}

variable "env_folder_name" {
  description = "folder name in the env_path with environment files"
}

###############################################################################
##### DEFAULT VARIABLES  ######################################################
###############################################################################

variable "subnet_zone_id" {
  description = "Zone id used for the subnet where network interface will be attached"
  default = "a"
}