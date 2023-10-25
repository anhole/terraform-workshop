terraform {
  backend "local" {
    path = "./.terraform-states/terraform.tfstate"
  }
}

# This requires that you have created a test state as stated in: ../1-backends/README.md
data "terraform_remote_state" "test_state" {
  backend = "local"

  config = {
    path = "../1-backends/.terraform-states/test/terraform.tfstate"
  }
}

resource "local_file" "remote_state" {
  filename = "${path.module}/remote-state-outputs.demo.txt"
  content  = <<EOF
Remote state
  Environment name: ${data.terraform_remote_state.test_state.outputs.environment_name}

Local file
  File name:       ${data.terraform_remote_state.test_state.outputs.local_file.filename}
  File permission: ${data.terraform_remote_state.test_state.outputs.local_file.file_permission}
  File MD5 hash:   ${data.terraform_remote_state.test_state.outputs.local_file.content_md5}
EOF
}

data "local_file" "remote_state_full" {
  filename = "../1-backends/.terraform-states/test/terraform.tfstate"
}

variable "hacker_mode_password" {
  description = "Enable the elite four digits to turn on hacker mode to see full remote state"
  type        = number
  default     = 0123
}

resource "local_file" "remote_state_full" {
  count = md5(var.hacker_mode_password) == "e48e13207341b6bffb7fb1622282247b" ? 1 : 0

  filename = "${path.module}/remote-state-full.demo.txt"
  content  = data.local_file.remote_state_full.content
}
