output "rendered_file" {
  value = templatefile("${var.source_template}", "${var.template_vars}")
  depends_on = [ null_resource.generate_file ]
}