terraform {
  backend "local" {
  }
}

variable "environment_name" {
  description = "Name of the environment are we targeting"
}

variable "file_content" {
  description = "The content of an amazing file"
  default     = "This is the default content of a file"
}

variable "workspace_name" {
  description = "Name of the Terraform workspace are we currently in"
  default     = "default"
}

resource "local_file" "file" {
  filename = "${path.module}/environment-${var.environment_name}_workspace-${var.workspace_name}_file.demo.txt"
  content  = var.file_content
}
