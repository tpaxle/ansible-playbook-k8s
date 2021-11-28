output "endpoint_reader_endpoint" {
  value = aws_docdb_cluster.cluster.reader_endpoint
}

output "endpoint_static_endpoint" {
  value = aws_docdb_cluster.cluster.endpoint
}

output "cluster_identifier" {
  value = aws_docdb_cluster.cluster.cluster_identifier
}
