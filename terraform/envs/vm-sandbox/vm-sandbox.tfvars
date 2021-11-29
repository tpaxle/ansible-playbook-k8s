
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


#########
dc_name           = "dc1"
dc2_name          = "dc2"
datastorage_name  = "storage1"
dc_template_name  = "dc2"
template_name     = "template_centos7"
dc_cluster_name   = "cluster1"
domain            = "lab.int"
