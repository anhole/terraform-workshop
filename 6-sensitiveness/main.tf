module "a" {
    source = "./a-module"
}

output "all-values" {
    value = module.a.all-values
    sensitive = true
}

output "some-values" {
    value = module.a.some-values
}

# Same as above but if we mark them as sensitive (even if they are not
# underneath), terraform will not show them
output "some-values-but-marked-as-sensitive" {
    value = module.a.some-values
    sensitive = true
}
