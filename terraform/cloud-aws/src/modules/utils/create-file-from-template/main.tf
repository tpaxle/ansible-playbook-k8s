resource "null_resource" "generate_file" {
  count = var.execution_count
  provisioner "local-exec" {
    command = "echo '${templatefile("${var.source_template}", "${var.template_vars}")}' > ${var.destination_file_path}"
  }
  depends_on = [var.template_depends_on]
}