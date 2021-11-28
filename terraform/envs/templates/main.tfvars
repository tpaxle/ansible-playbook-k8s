
##############################
##############################
####AWS Accounts
root_account  = "{{var_aws_authentication_root_account}}"
root_role_arn = "{{var_aws_authentication_role_arn}}"

##############################
##############################
##Template Variables
#####EKS
eks_worker_instance_type  = "{{var_aws_services_k8s_node_type}}"
eks_worker_desired        = "{{var_aws_services_k8s_eks_worker_desired}}"
eks_version               = "{{var_aws_services_k8s_version}}"
#####PSQL
rds_cluster_instance_class = "{{var_aws_services_psql_instance_type}}"
rds_cluster_total_instance = "{{var_aws_services_psql_rds_cluster_total_instance}}"
rds_cluster_version        = "{{var_aws_services_psql_engine_version}}"
#####REDIS
rdis_instance_type            = "{{var_aws_services_redis_rdis_instance_type}}"
rdis_engine_version           = "{{var_aws_services_redis_rdis_engine_version}}"
rdis_replicas_per_node_group  = "{{var_aws_services_redis_rdis_replicas_per_node_group}}"
rdis_num_node_groups          = "{{var_aws_services_redis_rdis_num_node_groups}}"
#####KAFKA
kafka_instance_type           = "{{var_aws_services_kafka_kafka_instance_type}}"
kafka_version                 = "{{var_aws_services_kafka_kafka_version}}"
kafka_broker_nodes_num        = "{{var_aws_services_kafka_kafka_broker_nodes_num}}"
##############################
##############################
#### VPC API GATEWAY   #######
##############################
api_gw_domain_name = "api-{{var_aws_ccoedata_application}}.{{var_aws_ccoedata_environment}}"
##############################
##############################
#### VPN details  ############
##############################
mgmt_pfsense_image_id = "ami-018ec1d352b155952"
mgmt_pfsense_instance_type  = "t2.micro"
az_dns_vpn  = "vpn-{{var_aws_ccoedata_application}}"
##############################
##############################
#Identifier objetcs
resource_prefix = "{{var_aws_ccoedata_application}}"
env             = "{{var_environment}}"
default_tags = {
  "PlatformName"  = "{{var_aws_ccoedata_platformname}}",
  "Environment"   = "{{var_aws_ccoedata_environment}}",
  "_Entity"       = "{{var_aws_ccoedata_entity}}",
  "_Application"  = "{{var_aws_ccoedata_application}}",
  "_Environment"  = "{{var_aws_ccoedata_environment}}",
  "_GeoRegion"    = "{{var_aws_ccoedata_georegion}}"
}
root_infra_domain  = "blue4sky.local"
root_public_domain = "blue4sky.com"

##############################
##############################
####Shared account
shared_role_arn      = "arn:aws:iam::966582751216:role/globile-shared-sso-administrator"
alternative_region   = "eu-west-1"
shared_connection_id = "pcx-051671677fd5298c8"
shared_account       = "966582751216"
shared_vpc           = "vpc-ca9afbac"


##############################
##############################
#### VPC AND NETWORKING#######
##############################
{%- if var_environment == "sandbox" %}
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
private_subnets_rds = [
  "10.128.2.0/27",
  "10.128.10.0/27",
  "10.128.18.0/27",
]
private_subnets_ris = [
  "10.128.2.32/27",
  "10.128.10.32/27",
  "10.128.18.32/27",
]
private_subnets_kfk = [
  "10.128.2.64/27",
  "10.128.10.64/27",
  "10.128.18.64/27",
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
{%- endif %}
{%- if var_environment == "develop" %}
vpc_cidr_block = "10.128.96.0/19"
public_subnets = [
  "10.128.96.0/25",
  "10.128.104.0/25",
  "10.128.112.0/25",
]
private_subnets_eks = [
  "10.128.100.0/24",
  "10.128.108.0/24",
  "10.128.116.0/24",
]
private_subnets_rds = [
  "10.128.98.0/27",
  "10.128.106.0/27",
  "10.128.114.0/27",
]
private_subnets_ris = [
  "10.128.98.32/27",
  "10.128.106.32/27",
  "10.128.114.32/27",
]
private_subnets_kfk = [
  "10.128.98.64/27",
  "10.128.106.64/27",
  "10.128.114.64/27",
]

kafka_allowed_cidrs = [
  "10.128.96.0/19",  # All gsandbox
  "10.128.64.0/21", # All gshared
]

rds_allowed_cidrs = [
  "10.128.96.0/19",  # All gsandbox
  "10.128.64.0/21", # All gshared
]
rdis_sg_access = [
  "10.128.100.0/24",
  "10.128.108.0/24",
  "10.128.116.0/24",
  "10.128.64.0/24"
]
{%- endif %}



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
  "kubernetes.io/cluster/{{var_aws_ccoedata_platformname}}-eks-main-{{var_environment}}" = "{{var_environment}}",
  "kubernetes.io/role/elb"                          = "1",
}
public_rt_tags = {
  "zone" = "public",
  "Team" = "{{var_aws_ccoedata_application}}",
}

#################### EKS Subnet


private_subnets_tags_eks = {
  "zone"    = "prveks-subnet",
  "Service" = "EKS",
}
private_rt_tags_eks = {
  "zone"    = "private",
  "Team"    = "{{var_platformname}}",
  "Service" = "EKS"
}

#################### RDS Subnet


private_subnets_tags_rds = {
  "zone"    = "prvrds-subnet",
  "Service" = "RDS"
}
private_rt_tags_rds = {
  "zone"    = "prvrds-subnet",
  "Team"    = "{{var_platformname}}",
  "Service" = "RDS"
}

#################### REDIS Subnet

private_subnets_tags_ris = {
  "zone"    = "prvris-subnet",
  "Service" = "REDIS"
}
private_rt_tags_ris = {
  "zone"    = "prvris-subnet",
  "Team"    = "{{var_platformname}}",
  "Service" = "KAFKA"
}
#################### KAFKA Subnet


private_subnets_tags_kfk = {
  "zone"    = "prvkfk-subnet",
  "Service" = "KAFKA"
}
private_rt_tags_kfk = {
  "zone" = "prvkfk-subnet",
  "Team" = "{{var_platformname}}",
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

##### Keys helm
kubernetes_helm_dashboard_chart_name         = "stable/kubernetes-dashboard"
kubernetes_helm_dashboard_chart_version      = "1.10.1"
kubernetes_helm_ingress_chart_name           = "stable/nginx-ingress"
kubernetes_helm_ingress_chart_version        = "1.36.3"
kubernetes_helm_kube-sm_chart_name           = "stable/kube-state-metrics"
kubernetes_helm_kube-sm_chart_version        = "2.8.4"
kubernetes_helm_metrics-server_chart_name    = "stable/metrics-server"
kubernetes_helm_metrics-server_chart_version = "2.11.1"
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



###############MYSQL config

mysql_loans_engine_version = "5.7.12"
envs_path = "../../../../../envs/"
