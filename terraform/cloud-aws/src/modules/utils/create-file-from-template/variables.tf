variable "template_vars" {
  description = "Variables to fill the template"
  type        = map(string)
}

variable "source_template" {
  description = "Source template content"
}

variable "destination_file_path" {
  description = "Destination filename and path"
}

variable "execution_count" {
  description = "Destination filename and path"
  default = 1
}

variable "template_depends_on" {
  # the value doesn't matter; we're just using this variable
  # to propagate dependencies.
  type    = any
  default = []
}