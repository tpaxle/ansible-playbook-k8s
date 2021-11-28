resource "aws_db_subnet_group" "default" {
  name       = var.subnetgroupname != "" ? var.subnetgroupname : "${var.baserdsname}${var.object_sequence}-sgr${var.object_sequence}"
  subnet_ids = var.subnets_ids

  tags = merge(
    {
      "Name"    = var.subnetgroupname != "" ? var.subnetgroupname : "${var.baserdsname}${var.object_sequence}-sgr${var.object_sequence}"
      "Subnets" = "VN RDS"
    },
    var.default_tags,
  )
}

resource "aws_docdb_cluster" "cluster" {
  cluster_identifier      = var.dbclustername != "" ? var.dbclustername : "${var.baserdsname}${var.object_sequence}-${var.database_name}"
  engine                  = var.engine
  availability_zones      = var.aws_azs
  master_username         = var.master_username
  master_password         = var.master_password
  
  deletion_protection     = var.deletion_protection
  vpc_security_group_ids  = var.vpc_security_group_ids
  storage_encrypted       = var.storage_encrypted
  kms_key_id              = var.kms_key_id

  backup_retention_period = 5
  preferred_backup_window = var.rds_preferred_maintenance_window
  db_subnet_group_name    = aws_db_subnet_group.default.id
  skip_final_snapshot     = true
  tags = merge(
    {
      "Name"     = var.dbclustername != ""  ? var.dbclustername : "${var.baserdsname}${var.object_sequence}-${var.database_name}"
      "Database" = var.database_name
    },
    var.default_tags,
  )
}

resource "aws_docdb_cluster_instance" "cluster_instances" {
  count              = 2
  identifier         = "${local.databasename}-${count.index}"
  cluster_identifier = aws_docdb_cluster.cluster.id
  instance_class     = var.instance_type
  engine             = var.engine
  tags = merge(
    {
      "Name"      = "${local.databasename}-${count.index}"
      "Cluster"   = local.databasename
    },
    var.default_tags,
  )  
}
