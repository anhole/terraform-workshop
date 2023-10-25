output "environment_name" {
  value = var.environment_name
}

# Output full local_file.file resource so that all values can be read using remote state
output "local_file" {
  sensitive = true
  value     = local_file.file
}

resource "random_password" "super_secure_password" {
  length  = 42
  special = true
}
