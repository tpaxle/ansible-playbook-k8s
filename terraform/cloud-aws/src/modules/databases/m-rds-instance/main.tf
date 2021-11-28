resource "aws_rds_cluster_instance" "cluster_instances" {
  count              = 2
  identifier         = "${var.baserdsname}${var.object_sequence}-${var.database_name}-${count.index}"
  cluster_identifier = var.cluster_id
  instance_class     = var.instance_type
  engine_version     = var.engine_version
  engine             = "aurora-postgresql"
  publicly_accessible  =  var.publicaccesible
}
