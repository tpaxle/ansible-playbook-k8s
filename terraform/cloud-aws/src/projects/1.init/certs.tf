###########################
## CREATING ECR ###########
###########################

resource "aws_acm_certificate" "blue4sky_root" {
  private_key       = data.template_file.all-blue4sky-privkey.rendered
  certificate_body  = data.template_file.all-blue4sky-cert.rendered
  certificate_chain = data.template_file.all-blue4sky-chain.rendered
  tags = merge(
    {
      "Name"  = "${module.naming_convention.basenamecrt}${module.naming_convention.default_object_sequence_number}"
      "App"   = "CERT"
      "Scope" = "Global certificate"
    },
    var.default_tags,
  )
}

