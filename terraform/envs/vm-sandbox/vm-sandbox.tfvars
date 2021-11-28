
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

##############################
##############################
#### VPC AND NETWORKING#######
##############################
vpc_cidr_block = "10.128.0.0/19"
public_subnets = [
  "10.128.0.0/25",
  "10.128.8.0/25",
  "10.128.16.0/25",
]
private_subnets_eks = [
  "10.128.4.0/24",
  "10.128.12.0/24",
  "10.128.20.0/24",
]

aws_azs = [
  "eu-west-2a",
  "eu-west-2b",
  "eu-west-2c",
]

#################### Public Subnet

public_subnets_tags = {
  "zone"                                            = "public",
  "kubernetes.io/cluster/vmwpoc-eks-main-s1" = "s1",
  "kubernetes.io/role/elb"                          = "1",
}
public_rt_tags = {
  "zone" = "public",
  "Team" = "platf5",
}

#################### EKS Subnet


private_subnets_tags_eks = {
  "zone"    = "prveks-subnet",
  "Service" = "EKS",
}
private_rt_tags_eks = {
  "zone"    = "private",
  "Team"    = "devops-platform5-terraform-test",
  "Service" = "EKS"
}



# S3
app_config_bucket_domain_name = "config.gdev.blue4sky.local"

#####################################
#####################################
########### EKS CONFIG ##############
#####################################
kubernetes_helm_dashboard_chart_name         = "kubernetes-dashboard"
kubernetes_helm_dashboard_chart_version      = "5.0.4"
kubernetes_helm_ingress_chart_name           = "nginx-ingress"
kubernetes_helm_ingress_chart_version        = "1.36.3"
kubernetes_helm_kube-sm_chart_name           = "kube-state-metrics"
kubernetes_helm_kube-sm_chart_version        = "4.0.2"
kubernetes_helm_metrics-server_chart_name    = "metrics-server"
kubernetes_helm_metrics-server_chart_version = "5.10.10"
kubernetes_helm_externaldns_chart_name       = "external-dns"
kubernetes_helm_externaldns_chart_version    = "5.5.0"
kubernetes_helm_prometheusop_chart_name      = "kube-prometheus-stack"
kubernetes_helm_prometheusop_chart_version   = "21.0.0"
kubernetes_helm_vault_chart_version          = "0.18.0"
eks_monitoring_worker_instance_type          = "t3.medium"
istio_version = "1.12.0"

####

##############################
##############################
####EKS CONFIGURATION
eks_worker_min            = 3
eks_worker_max            = 10
##############################



##############################
##############################
#### MODULES  ################
##############################
vault_enable_public = true
enable_k8s_istio    = true
enable_k8s_security = true
enable_k8s_keycloak = true
enable_k8s_elk      = true
enable_cicd         = false

###############MYSQL config

envs_path = "../../../../envs/"





#########
dc_name = "dc1"
datastorage_name = "storage1"
template_name = "centos7-kube-1.16"
dc_cluster_name = "cluster1"
domain          = "lab.int"
