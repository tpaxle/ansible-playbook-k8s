locals {
  databasename  = var.dbclustername != "" ? var.dbclustername : "${var.baserdsname}${var.object_sequence}-${var.database_name}"
}

