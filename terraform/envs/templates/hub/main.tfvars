
##############################
##############################
####AWS Accounts
root_account  = "{{var_aws_authentication_root_account}}"
root_role_arn = "{{var_aws_authentication_role_arn}}"

##############################
##############################
##Template Variables
#####EKS
eks_monitoring_worker_instance_type          = "t3.medium"
eks_worker_instance_type      = "{{var_aws_services_k8s_node_type}}"
eks_worker_desired            = "{{var_aws_services_k8s_eks_worker_desired}}"
eks_version                   = "{{var_aws_services_k8s_version}}"
#####PSQL
rds_cluster_instance_class    = "{{var_aws_services_psql_instance_type}}"
rds_cluster_total_instance    = "{{var_aws_services_psql_rds_cluster_total_instance}}"
rds_cluster_version           = "{{var_aws_services_psql_engine_version}}"
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
#### MODULES  ################
##############################
vault_enable_public = {% if var_aws_services_vault_public %}true{% else %}false{% endif %}
enable_k8s_istio    = {% if var_aws_services_istio_enable %}true{% else %}false{% endif %}
enable_k8s_security = {% if var_aws_services_security_enable %}true{% else %}false{% endif %}
enable_k8s_keycloak = {% if var_aws_services_keycloak_enable %}true{% else %}false{% endif %}
enable_cicd         = {% if var_aws_services_cicd_enable %}true{% else %}false{% endif %}

##############################
##############################
#### ECR REPOSITORIES ########
##############################

ecr_repository = ["platform-pipelines1-kotlin-app-back","platform-pipelines1-kotlin-app-back-chart"]


##############################
##############################
#### VPC API GATEWAY   #######
##############################
api_gw_domain_name           = "api-{{var_aws_ccoedata_application}}.{{var_aws_ccoedata_environment}}"

##############################
##############################
#### VPN details  ############
##############################
mgmt_pfsense_image_id       = "ami-018ec1d352b155952"
mgmt_pfsense_instance_type  = "t2.micro"
az_dns_vpn                  = "vpn-{{var_aws_ccoedata_application}}"
env_folder_name             = "hub"
mgmt_pfsense_dns_ip         = "10.128.64.2"

##############################
##############################
#Identifier objetcs
#resource_prefix = "{{var_aws_ccoedata_application}}"
#env             = "{{var_environment}}"
default_tags = {
  "PlatformName"  = "{{var_aws_ccoedata_platformname}}",
  "Environment"   = "{{var_aws_ccoedata_environment}}",
  "Infra-Unit"    = "{{var_environment}}",
  "_Entity"       = "{{var_aws_ccoedata_entity}}",
  "_Application"  = "{{var_aws_ccoedata_application}}",
  "_Environment"  = "hub",
  "_GeoRegion"    = "{{var_aws_ccoedata_georegion}}"
}
root_infra_domain  = "{{var_aws_ccoedata_application}}.int"
root_public_domain = "blue4sky.com"




##############################
##############################
#### GITHUB APP###############
##############################
github_app_key_base64     = "{{var_github_app_key_base64}}"
github_app_id             = "{{var_github_app_id}}"
github_app_client_id      = "{{var_github_client_id}}"
github_app_client_secret  = "{{var_github_client_secret}}"
runners_maximum_count     = 5
github_organization       = "{{var_github_organization}}"
github_adminteam          = "{{var_github_adminteam}}"

##############################
##############################
#### ANSIBLE MACHINE ########
##############################
mgmt_ansible_ami_source    = "ami-05c424d59413a2876"
mgmt_ansible_instance_type = "t2.medium"
mgmt_ansible_ami_name      = "ami-ansible"
packer_version             = "1.6.2"
packer_ssoo                = "darwin" #darwin macos
az_dns_ansible             = "ansible"
awx_version                = "15.0.0"
## ansible security group
ansible_es_access_cidr     = ["0.0.0.0/0"]

github_org_key              = "7b28b0f98f4268f02962"
github_org_secret           = "4144622cc56fdfc0f73b8b08134a0e3d3f479f2e"
github_org_name             = "{{var_github_organization}}"

##############################
##############################
#### VPC AND NETWORKING#######
##############################
vpc_cidr_block    = "10.128.64.0/21"
vpcflow_log_type  = "REJECT"
aws_azs = [
  "eu-west-2a",
  "eu-west-2b",
  "eu-west-2c",
]

#Public Subnet
public_subnets = [
  "10.128.64.0/26",
  "10.128.64.64/26",
  "10.128.64.128/26",
]
public_subnets_tags = {
  "zone"                    = "hub-public",
  "kubernetes.io/cluster/{{var_aws_ccoedata_application}}-eks-main-hub"= "hub",
  "kubernetes.io/role/elb"  = "1",
}
public_rt_tags = {
  "zone" = "hub-public",
  "Team" = "{{var_aws_ccoedata_application}}",
}

# EKS Subnet
private_eks_subnets = [
  "10.128.66.0/25",
  "10.128.66.128/25",
  "10.128.67.0/25",
]
private_eks_subnets_tags = {
  "zone" = "hub-private-eks",
}
private_rt_eks_tags = {
  "zone" = "hub-private",
  "Team" = "{{var_aws_ccoedata_application}}",
}

# ES Subnet
private_subnet_es = [
  "10.128.65.0/26",
  "10.128.65.64/26",
  "10.128.65.128/26",
]
private_subnets_es_tags = {
  "zone" = "hub-private-es",
}
private_rt_es_tags = {
  "zone" = "hub-private",
  "Team" = "{{var_aws_ccoedata_application}}",
}

#################### MGMT Subnet
private_subnet_mgmt = [
  "10.128.68.0/27",
  "10.128.68.32/27",
  "10.128.68.64/27",
]
private_subnets_mgmt_tags = {
  "zone" = "hub-mgmt-services"
}
private_rt_mgmt_tags = {
  "zone" = "hub-private-services",
  "Team" = "{{var_aws_ccoedata_application}}",
}



##############################
##############################
#### KAFKA CONFIG  ###########
##############################
default_kafka_partitions            = 16
default_kafka_deadletter_partitions = 2
default_kafka_min_isr               = 1
default_kafka_retention_ms          = 604800000
default_kafka_segment_ms            = 300000


#############################
#############################
#### RDS CONFIG  ############
#############################

rds_backup_retention_period       = 1
rds_preferred_backup_window       = "02:00-03:00"
rds_preferred_maintenance_window  = "03:00-04:00"
rds_apply_immediately             = true
rds_storage_encrypted             = true
rds_publicly_accessible           = false
rds_monitoring_interval           = 15
rds_accounts_master_username      = "vmware_db_user"

#############################
#############################
#### K8S SERVICES  ##########
#############################
kubernetes_helm_dashboard_chart_name         = "kubernetes-dashboard"
kubernetes_helm_dashboard_chart_version      = "1.11.1"
kubernetes_helm_ingress_chart_name           = "nginx-ingress"
kubernetes_helm_ingress_chart_version        = "1.36.3"
kubernetes_helm_kube-sm_chart_name           = "kube-state-metrics"
kubernetes_helm_kube-sm_chart_version        = "2.9.1"
kubernetes_helm_metrics-server_chart_name    = "metrics-server"
kubernetes_helm_metrics-server_chart_version = "2.11.1"
kubernetes_helm_externaldns_chart_name       = "external-dns"
kubernetes_helm_externaldns_chart_version    = "2.20.4"
kubernetes_helm_prometheusop_chart_name      = "prometheus-operator"
kubernetes_helm_prometheusop_chart_version   = "9.3.2"
kubernetes_helm_sonar_chart_name             = "sonarqube"
kubernetes_helm_sonar_chart_version          = "6.8.0"
kubernetes_helm_vault_chart_version          = "0.7.0"
kubernetes_helm_nexus_chart_name             = "sonatype-nexus"
kubernetes_helm_nexus_chart_version          = "2.8.0"


#############################
#############################
#### K8S config  ############
#############################
eks_worker_min            = 3
eks_worker_max            = 10
##############################


#############################
#############################
#### REDS CONFIG  ###########
#############################
rdis_maintenance_window       = "sun:03:00-sun:05:00"
rdis_snapshot_window          = "00:00-01:05"
rdis_snapshot_retention_limit = "3"

#Security
rdis_at_rest_encrypt = "true"
rdis_transit_encrypt = "true"
#Cluster

##############################
##############################
#### VAULT  ##################
##############################
vault_ip_access = [
  "83.32.42.0/24",
  "82.31.125.122/32",
  "83.144.67.82/32",
  "139.47.90.5/32",
  "83.59.57.188/32", #Pablo
]
az_dns_vault = "vault-{{var_aws_ccoedata_application}}"

#############################
#############################
#### OTHERS  ################
#############################
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
