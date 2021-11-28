###############################################################################
##### DEFAULT VARIABLES  ######################################################
###############################################################################

variable "region" {
  description = "Region to base all of our commands on"
}

variable "naming_convention_definition" {
  description = "Map the following variables defined (basenamebucket, baseiamrole, basekmskey, baserdsname, basekfkname, basenamevpc, basenamecrd, basenamenlb, basenamecrt, basenameigw, basenamengw, basenameeip, basenamesnt, basenamertb, basenamedns, baseiampolicy, basenameclr, basenamecwf, basenamecld, basenamekfd, basenamelambdafunction, basenamelogs and basenamesgr)"
  type = map
  default = {}
}
/*
 naming_convention_definition = {
    "basenamebucket" ="xxxxx",
    "baseiamrole"   = "xxxxx",
    "basekmskey"    = "xxxxx",
    "baserdsname"   = "xxxxx",
    "basekfkname"   = "xxxxx",
    "basenamevpc"   = "xxxxx",
    "basenamecrd"   = "xxxxx",
    "basenamenlb"   = "xxxxx",
    "basenamecrt"   = "xxxxx",
    "basenameigw"   = "xxxxx",
    "basenamengw"   = "xxxxx",
    "basenameeip"   = "xxxxx",
    "basenamesnt"   = "xxxxx",
    "basenamertb"   = "xxxxx",
    "basenamedns"   = "xxxxx",
    "baseiampolicy" = "xxxxx",
    "basenameclr"   = "xxxxx",
    "basenamecwf"   = "xxxxx",
    "basenamecld"   = "xxxxx",
    "basenamekfd"   = "xxxxx",
    "basenamelambdafunction"   = "xxxxx",
    "basenamelogs"   = "xxxxx",
    "basenamesgr"   = "xxxxx"
  }
:º
  basenamebucket          -> Basename of the bucket to store the data resources. 
  baseiamrole             -> Basename for Identity Access Management(iam) role to access resources. 
  basekmskey              -> Key Management Service(kms) key basename.
  baserdsname             -> Relational Database Service (RDS) basename.
  basekfkname             -> Kafka basename.
  basenamevpc             -> Virtual Private Cloud(vpc) basename.
  basenamecrd             -> Basename of the Cluster for Remote Dictionary Server(redis).
  basenamenlb             -> Basename for the  Network Load Balancer (nlb). 
  basenamecrt             -> Basename for Amazon Certificate Manager (acr).
  basenameigw             -> Basename for Amazon Internet Gateway (igw).
  basenamengw             -> Basename for Amazon NAT Gateway (ngw).
  basenameeip             -> Basename for Elastic Resource IP (eip).
  basenamesnt             -> Basename for Subnet resource.
  basenamertb             -> Basename for Routing table resource.
  basenamedns             -> Basename for DNS zone.
  baseiampolicy           -> Basename for Identity Access Management(iam) permission policy.
  basenameclr             -> Basename for AWS CloudTrail service.
  basenamecwf             -> Basename for AWS CloudWatch service.
  basenamecld             -> Basename for AWS CloudWatch log destination resource.
  basenamekfd             -> Basename for AWS Kinesis Firehose Delivery Stream service.
  basenamelambdafunction  -> Basename for AWS Lambda function resource.
  basenamelogs            -> Basename for CloudWatch Log Group resource.
  basenamesgr             -> Basename for Security Group resource.
*/


variable "entity" {
  description = "Entity Name"
  default = "sdi"
}

variable "environment" {
  description = "Environment"
  default = "s1"
}

variable "geo_region" {
  default = "ald"
}

variable "application" {
  default = "globil"
}