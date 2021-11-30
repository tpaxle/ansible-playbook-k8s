# Platform terraform AWS
= GLOBAL - HeraWebhookChecker Terraform Project
:authors: ALM PLATFORM Team
:doctype: book
:toc: center
:toclevels: 4
:pagenums:
:icons: font
:source-highlighter: rouge
:rouge-style: monokai
:jarvis-version: 1.0
:imagesdir: ./docs/images
:title-logo-image: {imagesdir}/almmc.png

== Introduction

This repo contains all the logic to deploy a new HeraWebhookChecker based on https://github.com/santander-group/global-service-herawebhookchecker[global-service-herawebhookchecker Software].  This repo contains all the terraform files required to deploy the different services which will  be described below.

image::draws.png[align="center", title-align="Azure Diagram"]

== Terraform Project

This project contains a terraform Project with differents resources based on Azure Resources provider. The minimum terraform version compatible with the solution is 1.0.1 and the Azure provider is 2.65.0.

Project structure:
----
.
├── azure-pipelines.yml
├── envs
│   ├── pre
│   │   ├── pre.tfvars
│   │   └── webhook.pfx
│   └── test_pre
│       └── test_pre.tfvars
├── README.adoc
├── README.md
└── src
    ├── modules
    │   └── appgw
    │       ├── data.tf
    │       ├── main.tf
    │       ├── outputs.tf
    │       ├── README.md
    │       ├── variables.tf
    │       └── versions.tf
    └── project
        ├── conf
        │   ├── envoy.cfg.tpl
        │   ├── nginx.conf
        │   ├── ssl.crt
        │   ├── ssl.key
        │   └── webhook.pfx
        ├── data.tf
        ├── main.tf
        ├── output.tf
        ├── providers.tf
        ├── readme.md
        └── variables.tf
----


The Project required the folowing information:

**General information**
----
###############################################################################
##### DEFAULT INFORMATION PROVIDED BY CCOE ####################################
###############################################################################

resource_group       = "ccci1weursgalmngncomm001"
resource_group_nets  = "ccci1weursgplatfoglob001"
keyvault_name        = "ccci1weuakvalmngncomm001"

vnet_aci             = "ccci1weuvntplatfoglob001"
subnet_aci           = "ccci1weuvntplatfoglob001-snt02"
subnet_lb            = "ccci1weuvntplatfoglob001-snt03"

###TAGS
cia           = ""
channel       = "xxxx"
description   = "LB to provide HA on containers"
tracking_code = "xxxx"

default_tags         = {
  "Service_URL"   = "webhook.almpre.cloudcenter.corp"
  "Service_Proxy"   = "https://<master>.jenkins.almpre.europe.cloudcenter.corp"  
  "Service"       = "*** ALM Cloudbees PRE "
}
----

[vertical]
resource_group:: Resource Group name assgined for the environment for this project.
resource_group_nets:: Resource_group where the subnets are located (CCOE).
vnet_aci:: Vnet name
subnet_aci:: Subnet assgined to ACI service. **Check Requirements**
subnet_lb:: Subnet assigned to APGW. 
Tags:: Extra information for billing and organization.

Service information
----
###############################################################################
##### SERVICE SPECIFIC INFORMATION ############################################
###############################################################################

#####Azure Container Group
acg_name             = "ccci1weuacialmngncomm001"

##Containers number
acg_cfg_cnt_number   = 2


acg_cfg_dns_servers = ["180.156.2.165"]

##Network configuration
private_ip_address   = "180.156.4.68"          
private_ip_address_allocation = "Static"

#####Application Gateway
appgw_name    = "ccci1weuagwalmngncomm001"
capacity      = "1"
sku_name      = "Standard_Small"
sku_tier      = "Standard"
cert_path     = "../../envs/pre/pre.pfx"
----

[vertical]
acg_name:: Azure container instance name. To be compliance with the naming convention, you could use the Naming Convention calculator in docs/.
acg_cfg_cnt_number:: Number of Herawebhookchecker pods running on the container instance.
acg_cfg_dns_servers :: DNS Ip. It is specific of the ACI Subnet. (CCOE)
private_ip_address:: IP address assigned to ACI.
private_ip_address_allocation:: Static or Dynamic.
appgw_name:: Application Gateway Name (check naminconvention).
capacity:: number of nodes.
sku_name and tier:: Size of the VMs and services/licenses provided.
cert_path:: Path where the ssl certificate is ubicated.


The above information should be saved on envs folder withe the name of the environment:

----
envs/<environment>/<environment>.tfvars
----

=== Modules


There are 3 important componets:

  * **Application Gateway:** 

  The applicatin gateway is responsible to connect the Service with the rest of the network. The principal function is the SSL offloading. the SSL ends on the application gateway and this sends the request to the Azure Container Group. The solution has been designed to balance the traffic between differents ACI services.

  It only uses a private IP in the specific subnet.

  The application gateway checks the health of the backends using /health endpoint of the herawebhookchecker. 

  * **Azure Container Group:**

  We need to deploy an azure Container group where we will deploy the differents containers. This service is connected with the network through an endpoint connection. An internal IP is created to this services and it is the central point to access to the services. 

  https://docs.microsoft.com/en-us/azure/container-instances/

  * **Containers:**

  There are 2 kinds of containers. First of all, envoy container. this pod is a container load balancer who is responsible to redirect the traffic between the different Hera containers. The second type is Hera Containers, is based on the https://github.com/santander-group/global-service-herawebhookchecker/pkgs/container/global-service-herawebhookchecker[docker image] pushed to github packages. The container number is specified on environment variables.


=== Backend Configuration

To keep the tfstate configuration and to handle what is the status of the platform and how to apply the new configuration, new configuration is required but it is in secrets files. 

The solution is designed to keep the information on the Storage Account ubicated in the Resource Group.

You can find the required information  per environment below:

[vertical]
storage_account_name:: The storage account name.
container_name:: This is the bucked where the tfstate is ubicated.
key:: Name of the tfstate file
resource_group_name:: Resource Group where the storage account is ubicated.
subscription_id:: Azure subscription ID where we are deploying the solution
tenant_id:: Azure tennant ID.
client_id:: SP3 id.
client_secret:: SP3 secret.


This information is provided using secrets on github actions or using an azure connector if we are using azure devops:
----
        terraform init \
        -backend-config=storage_account_name=${{ secrets.TF_BE_STORAGE_ACCOUNT }} \
        -backend-config=container_name=${{ secrets.TF_BE_CON_NAME }} \
        -backend-config=key=${{ secrets.TF_BE_KEY }} \
        -backend-config=resource_group_name=${{ secrets.TF_BE_RSG }} \
        -backend-config=subscription_id=${{ secrets.TF_BE_SUBSCRIPTION_ID }} \
        -backend-config=tenant_id=${{ secrets.TF_BE_TENANT_ID }} \
        -backend-config=client_id=${{ secrets.TF_BE_CLIENT_ID }} \
        -backend-config=client_secret=${{ secrets.TF_BE_CLIENT_SECRET }}
----


== CD:

== Requirements:

- A specific Resource Group per environment containing an Storage Account where the tfstate will be kept.
- 1 subnet for Azure Container Instance /27.
- 1 subnet for the LB/APP GW /28.
- Connectivity between the ACI subnet and the upstream server.
- Connectivity between the Github Enterprise (public or private) with the service.
- [PRO] Public IP on North Firewall Nated to the APGW IP.
- Domain name per environment.
- Certificate for the domainname selected.
- Github.com PAT with packages permissions On https://github.com/santander-group/global-service-HeraWebhookChecker[heraWebChecker repo]


[NOTE]
====
.Keep in mind:
- The ACI subnet should be delegated to "Microsoft.ContainerInstance"
- The SP3 should have permissions to perform joinLoadBalancer action on the VNET.
- The SP3 should have certificates Import,delete,prunning permissions on the keyvault.
- The Application Gateway is Small and standard.
- The certificate can´t be on the keyvault because of the kind of APGW.
====
=== Environment Groups:

There are 2 environment groups for CD:


[vertical]
TF_BE_RSG:: Resource group where the storage account is ubicated
TF_BE_STORAGE_ACCOUNT:: The storage account name.
TF_BE_CON_NAME:: This is the bucket (blob) where the tfstate is ubicated.
TF_BE_KEY:: Name of the tfstate file
TF_BE_SUBSCRIPTION_ID:: Azure subscription ID where we are deploying the solution
TF_BE_TENANT_ID:: Azure tennant ID.
TF_BE_CLIENT_ID:: SP3 id (app_id).
TF_BE_CLIENT_SECRET:: SP3 secret.
TF_CERTIFICATE_B64:: base64 pfx file.
  * PRE: Environment variables for deploying on pre environment
  * PRO: Environment variables for deploying on pro environment

Generating a self-signed certificate.

----
  sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout selfsigned.key -out selfsigned.crt
  sudo openssl pkcs12 -inkey selfsigned.key -in selfsigned.crt -export -out selfsigned.pfx
  # Default password we can change in azurerm_key_vault_certificate
  password :> webhook  
  # convert binary to base64 to set environment variable
  sudo cat ./selfsigned.pfx | base64   

  MIIJqQIBAzCCCW8GCSqGSIb3DQEHAaCCCWAEgglcMIIJWDCCBA8GCSqGSIb3DQEHBqCCBAAwggP8
  AgEAMIID9QYJKoZIhvcNAQcBMBwGCiqGSIb3DQEMAQYwDgQI6FBDWpaRvOECAggAgIIDyB64SMKh
  +w+K8wnuBTCukpVWNJaY1IfaFF5XnZcyon/I30kuFepDRkuivFEjD7oOxEFCPk1mCQDnHjBvNLBs
  ....
  CsaVlYeZLnAx5/Ss0Uy0uB+MVXbic6f0yO3RrxnJUyYjj4HFo4Y+Dofx4Go2g4yJdNOkMVe9NY7Z
  2fj8PXuqJNcYWNcouPLwdQUGGMrxKapHbA5D8k7LgPIYdIkJ203IOEeUjDQ7xMlLviYxJTAjBgkq
  hkiG9w0BCRUxFgQU8cM/OtlMQVFIt+01PbQcIkubELAwMTAhMAkGBSsOAwIaBQAEFBxkhecCAv2e
  rWDkEpydSM9BBPtDBAhN+LaR3Dm6qAICCAA=
----

  
=== Errors:

Deletgation subnet problem:
----
Buenas, al intentar otorgar permisos : Failed to save subnet 'ccci1weuvntplatfoglob001-snt02'. Error: 'Delegations of subnet ccci1weuvntplatfoglob001/ccci1we0uvntplatfoglob001-snt02 cannot be changed from [] to [Microsoft.ContainerInstance/containerGroups] because it is being used by the resource /subscriptions/6cd64214-9702-4dca-aaae-c53dbbe15572/resourceGroups/ccci1weursgalmngncomm001/providers/Microsoft.Network/networkProfiles/webhooknetprofile/containerNetworkInterfaceConfigurations/webhookcnic/ipConfigurations/webhookipconfig.'
----

This problem is solved configuring the subnet delegation to Microsoft.ContainerInstance.

JoinLoadBalancer Problem:
----
 updating Backend Address Pool Address: (Address Name "ccci1weulbaalmngncomm001-apa-02" / Backend Address Pool Name "ccci1weulbaalmngncomm001-bap-01" / Load Balancer Name "ccci1weulbaalmngncomm001" / Resource Group "ccci1weursgalmngncomm001"): network.LoadBalancerBackendAddressPoolsClient#CreateOrUpdate: Failure  sending request: StatusCode=0 -- Original Error: Code="LinkedAuthorizationFailed" Message="The client '33aa612e-7d74-4ca9-a574-3ec5b29d5099' with object id '33aa612e-7d74-4ca9-a574-3ec5b29d5099' has permission to perform action  'Microsoft.Network/loadBalancers/backendAddressPools/write' on scope '/subscriptions/6cd64214-9702-4dca-aaae-c53dbbe15572/resourceGroups/ccci1weursgalmngncomm001/providers/Microsoft.Network/loadBalancers/ccci1weulbaalmngncomm001/backendAddressPools/ccci1weulbaalmngncomm001-bap-01'; however, it does not have permission to perform action 'Microsoft.Network/virtualNetworks/joinLoadBalancer/action' on the linked scope(s) '/subscriptions/6cd64214-9702-4dca-aaae-c53dbbe15572/resourceGroups/ccci1weursgplatfoglob001/providers/Microsoft.Network/virtualNetworks/ccci1weuvntplatfoglob001' or the linked scope(s) are invalid." 
----

This problem is solved adding JoinLoadBalancer action permissions to the SP3 on the VNET

KeyVault Handleing:
----
│ Error: keyvault.BaseClient#ImportCertificate: Failure responding to request: StatusCode=403 -- Original Error: autorest/azure: Service returned an error. Status=403 Code="Forbidden" Message="The user, group or application 'appid=***;oid=33aa612e-7d74-4ca9-a574-3ec5b29d5099;numgroups=0;iss=https://sts.windows.net/***/' does not have **certificates import permission** on key vault 'ccci1weuakvalmngncomm001;location=westeurope'. For help resolving this issue, please see https://go.microsoft.com/fwlink/?linkid=2125287" InnerError={"code":"ForbiddenByPolicy"}

│ Error: deleting Certificate "imported-cert" (Key Vault "https://ccci1weuakvalmngncomm001.vault.azure.net/"): keyvault.BaseClient#DeleteCertificate: Failure responding to request: StatusCode=403 -- Original Error: autorest/azure: Service returned an error. Status=403 Code="Forbidden" Message="The user, group or application 'appid=***;oid=33aa612e-7d74-4ca9-a574-3ec5b29d5099;iss=https://sts.windows.net/***/' does not have certificates delete permission on key vault 'ccci1weuakvalmngncomm001;location=westeurope'. For help resolving this issue, please see https://go.microsoft.com/fwlink/?linkid=2125287" InnerError={"code":"ForbiddenByPolicy"}
----
This problem is solved adding certificates Import, delete, prune permissions to the SP


Certificated without password
----
│  Error: creating/updating Application Gateway: (Name "sgtp1weuagwalmngncomm001" / Resource Group "***"): network.ApplicationGatewaysClient#CreateOrUpdate: Failure sending request: StatusCode=0 -- Original Error: Code="ApplicationGatewaySslCertificatePasswordIncorrect" Message="Password specified for certificate /subscriptions/***/resourceGroups/***/providers/Microsoft.Network/applicationGateways/sgtp1weuagwalmngncomm001/sslCertificates/sgtp1weuagwalmngncomm001-cert is incorrect." Details=[]
----

Generate certificate with password , see TF_CERTIFICATE_B64 environment variable


Assing ip reserved at applicationGateways
----
│   Error: creating/updating Application Gateway: (Name "sgtp1weuagwalmngncomm001" / Resource Group "***"): network.ApplicationGatewaysClient#CreateOrUpdate: Failure sending request: StatusCode=0 -- Original Error: Code="PrivateIPAddressInReservedRange" Message="Private static IP address 107.104.65.34 **falls within reserved IP range of subnet** prefix 107.104.65.32/28." Details=[]
----

documetation : https://docs.microsoft.com/en-us/azure/application-gateway/configuration-infrastructure

Change IP with other not reserved and pull-request to main



== FAQS

=== 1. Add new organizations to the allow list.

You only need to modify the varialbe herawc_opts_endpoint on the specific environment file (envs/<environment>/<environment>.tfvars) with the new list. Once is merged to master, an action is going to redeploy the environments.

IMPORTANT: The terraform provider doesn´t allow the modifications of the containers. it only recreates the ACI service and recreate the environment --> If you redeploy you will have a service outage.

=== 2. Create pfx certificate for APP GW.

Azure APPGw only accept pfx certificates. You can create this pfx from cer/crt+key files and publish this base64 on Github envs TF_CERTIFICATE_B64:
----
openssl pkcs12 -inkey cert_key.key -in cert.cer -export -out /tmp/certification_name.pfx
cat /tmp/certification_name.pfx | base64 
----

