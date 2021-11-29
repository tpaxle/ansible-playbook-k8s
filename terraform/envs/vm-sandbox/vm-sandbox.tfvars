
##############################
##############################
####AWS Accounts
root_account  = "909517579108"
role_arn_fin     = "arn:aws:iam::909517579108:terraform-iac"
root_role_arn = "arn:aws:iam::909517579108:role/terraform-iac"

##############################
##############################

## Otras
ecr_repository      = ["test"]
##Template Variables
#####EKS
eks_worker_instance_type  = "t3.medium"
eks_worker_desired        = "3"
eks_version               = "1.21"

##############################
##############################
#### VPC API GATEWAY   #######
##############################
api_gw_domain_name = "api"
api_sv_domain_name = "sv-api"
az_dns_vault = "vault"

##############################
##############################
#### VPN details  ############
##############################
mgmt_pfsense_image_id = "ami-0893a4e37a365c450"
mgmt_pfsense_instance_type  = "t2.micro"
mgmt_pfsense_dns_ip = "10.128.0.2"
az_dns_vpn  = "vpn-platf5"
##############################
##############################
#Identifier objetcs
resource_prefix = "vmwpoc"
env             = "sandbox"
default_tags = {
  "PlatformName"  = "devops-platform5-terraform-test",
  "Environment"   = "s1",
  "Infra-Unit"    = "sandbox",
  "_Entity"       = "sdi",
  "_Application"  = "platf5",
  "_Environment"  = "s1",
  "_GeoRegion"    = "lnd"
}
root_infra_domain  = "blue4sky.local"
root_public_domain = "poc.blue1sky.me"


#########
dc_name           = "dc1"
dc2_name          = "dc2"
datastorage_name  = "storage1"
dc_template_name  = "dc2"
template_name     = "template_centos7"
dc_cluster_name   = "cluster1"
domain            = "lab.int"
