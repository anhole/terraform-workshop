module "b" {
    source = "./b-module"
}

output "all-values" {
    value = module.b
}

output "some-values" {
    value = {
        COOL = module.b.COOL,
        blah = module.b.blah,
    }
}
