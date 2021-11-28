locals {
  basenamebucket        = lookup(var.naming_convention_definition, "basenamebucket", "${var.entity}${var.environment}${var.geo_region}abk${var.application}fede")
  baseiamrole           = lookup(var.naming_convention_definition, "baseiamrole"  , "${var.entity}${var.environment}${var.geo_region}irl${var.application}csec")
  basekmskey            = lookup(var.naming_convention_definition, "basekmskey"   , "${var.entity}${var.environment}${var.geo_region}kms${var.application}comm")
  baserdsname           = lookup(var.naming_convention_definition, "baserdsname"  , "${var.entity}${var.environment}${var.geo_region}rds${var.application}comm")
  basedyntbname         = lookup(var.naming_convention_definition, "baserdsname"  , "${var.entity}${var.environment}${var.geo_region}dyt${var.application}comm")
  basekfkname           = lookup(var.naming_convention_definition, "basekfkname"  , "${var.entity}${var.environment}${var.geo_region}kfk${var.application}comm")
  basenamevpc           = lookup(var.naming_convention_definition, "basenamevpc"  , "${var.entity}${var.environment}${var.geo_region}vpc${var.application}nthb")
  basenamecrd           = lookup(var.naming_convention_definition, "basenamecrd"  , "${var.entity}${var.environment}${var.geo_region}lcr${var.application}comm")
  basenamenlb           = lookup(var.naming_convention_definition, "basenamenlb"  , "${var.entity}${var.environment}${var.geo_region}elb${var.application}nthb")
  basenamecrt           = lookup(var.naming_convention_definition, "basenamecrt"  , "${var.entity}${var.environment}${var.geo_region}crt${var.application}auth")
  basenameigw           = lookup(var.naming_convention_definition, "basenameigw"  , "${var.entity}${var.environment}${var.geo_region}igw${var.application}nthb")
  basenamengw           = lookup(var.naming_convention_definition, "basenamengw"  , "${var.entity}${var.environment}${var.geo_region}ngw${var.application}nthb")
  basenameeip           = lookup(var.naming_convention_definition, "basenameeip"  , "${var.entity}${var.environment}${var.geo_region}eip${var.application}nthb")
  basenamesnt           = lookup(var.naming_convention_definition, "basenamesnt"  , "${var.entity}${var.environment}${var.geo_region}snt${var.application}nthb")
  basenamertb           = lookup(var.naming_convention_definition, "basenamertb"  , "${var.entity}${var.environment}${var.geo_region}rtb${var.application}nthb")
  basenamedns           = lookup(var.naming_convention_definition, "basenamedns"  , "${var.entity}${var.environment}${var.geo_region}dns${var.application}nthb")
  baseiampolicy         = lookup(var.naming_convention_definition, "baseiampolicy"  , "${var.entity}${var.environment}${var.geo_region}ipl${var.application}csec")
  basenameclr           = lookup(var.naming_convention_definition, "basenameclr"  ,"${var.entity}${var.environment}${var.geo_region}clr${var.application}csec")
  basenamecwf           = lookup(var.naming_convention_definition, "basenamecwf"  ,"${var.entity}${var.environment}${var.geo_region}cwf${var.application}csec")
  basenamecld           = lookup(var.naming_convention_definition, "basenamecld"  ,"${var.entity}${var.environment}${var.geo_region}cld${var.application}csec")
  basenamekfd           = lookup(var.naming_convention_definition, "basenamekfd"  ,"${var.entity}${var.environment}${var.geo_region}kfd${var.application}csec")
  basenamelambdafunction  = lookup(var.naming_convention_definition, "basenamelambdafunction"  ,"${var.entity}${var.environment}${var.geo_region}lbf${var.application}csec")
  basenamelogs          = lookup(var.naming_convention_definition, "basenamelogs"  ,"${var.entity}${var.environment}${var.geo_region}clg${var.application}csec")
  basenamesgr           = lookup(var.naming_convention_definition, "basenamesgr"  ,"${var.entity}${var.environment}${var.geo_region}sgr${var.application}nthb")
  default_object_sequence_number = "001"
  ris_object_sequence = "004"
}



