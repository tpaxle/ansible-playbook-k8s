
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
#####PSQL
rds_cluster_instance_class = "db.r4.large"
rds_cluster_total_instance = "3"
rds_cluster_version        = "11.6"
#####REDIS
rdis_instance_type            = "cache.m5.large"
rdis_engine_version           = "5.0.6"
rdis_replicas_per_node_group  = "2"
rdis_num_node_groups          = "3"
#####KAFKA
kafka_instance_type           = "kafka.t3.small"
kafka_version                 = "2.2.1"
kafka_broker_nodes_num        = "3"
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
resource_prefix = "platf5"
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
####Shared account
shared_role_arn      = "arn:aws:iam::966582751216:role/vmware-shared-sso-administrator"
alternative_region   = "eu-west-1"
shared_connection_id = "pcx-051671677fd5298c8"
shared_account       = "966582751216"
shared_vpc           = "vpc-ca9afbac"


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

kafka_allowed_cidrs = [
  "10.128.0.0/19",  # All gsandbox
  "10.128.64.0/21", # All gshared
]

rds_allowed_cidrs = [
  "10.128.0.0/19",  # All gsandbox
  "10.128.64.0/21", # All gshared
]
rdis_sg_access = [
  "10.128.4.0/24",
  "10.128.12.0/24",
  "10.128.20.0/24",
  "10.128.64.0/24"
]



### Secundary
shared_cidr_block   = "10.128.64.0/21"
shared_region       = "eu-west-2"
enable_vpcflow_logs = 0

aws_azs = [
  "eu-west-2a",
  "eu-west-2b",
  "eu-west-2c",
]

#################### Public Subnet

public_subnets_tags = {
  "zone"                                            = "public",
  "kubernetes.io/cluster/devops-platform5-terraform-test-eks-main-sandbox" = "sandbox",
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

#################### RDS Subnet


private_subnets_tags_rds = {
  "zone"    = "prvrds-subnet",
  "Service" = "RDS"
}
private_rt_tags_rds = {
  "zone"    = "prvrds-subnet",
  "Team"    = "devops-platform5-terraform-test",
  "Service" = "RDS"
}

#################### REDIS Subnet

private_subnets_tags_ris = {
  "zone"    = "prvris-subnet",
  "Service" = "REDIS"
}
private_rt_tags_ris = {
  "zone"    = "prvris-subnet",
  "Team"    = "devops-platform5-terraform-test",
  "Service" = "KAFKA"
}
#################### KAFKA Subnet


private_subnets_tags_kfk = {
  "zone"    = "prvkfk-subnet",
  "Service" = "KAFKA"
}
private_rt_tags_kfk = {
  "zone" = "prvkfk-subnet",
  "Team" = "devops-platform5-terraform-test",
}


##############################
##############################
#### KAFKA CONFIG  ###########
##############################
kafka_broker_leader                 = "10.10.5.232:9092"
default_kafka_partitions            = 16
default_kafka_deadletter_partitions = 2
default_kafka_min_isr               = 1
default_kafka_retention_ms          = 604800000
default_kafka_segment_ms            = 300000



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
####

##############################
##############################
####EKS CONFIGURATION
eks_worker_min            = 3
eks_worker_max            = 10
##############################


### Redis
rdis_maintenance_window       = "sun:03:00-sun:05:00"
rdis_snapshot_window          = "00:00-01:05"
rdis_snapshot_retention_limit = "3"

######Security
rdis_at_rest_encrypt = "true"
rdis_transit_encrypt = "true"
#######Cluster


public_env            = "gdev.gb"
cloudwatch_log_groups = []

#####Azure
#####
az_dns_name = "blue4sky.com"
az_rg_name  = "sdid1weursgglobilcomm001"
###########
vault_user_arn  = "arn:aws:iam::011706625149:user/jenkins-user"
env_folder_name = "sandbox"

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

mysql_loans_engine_version = "5.7.12"
envs_path = "../../../../envs/"
istio_version = "1.12.0"
