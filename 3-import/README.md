# Terraform Import

Starting in Terraform version 1.5.0 a new `import` block is supported. This is helpful when switching from
[ClickOps](https://docs.cloudposse.com/glossary/clickops/) to [Infrastructure as Code](https://docs.cloudposse.com/glossary/infrastructure-as-code/)

`import` block differs from CLI `terraform import resource_type.resource_name` in that its configuration driven
and will work more reliably in pipelines. During a `terraform plan` and `terraform apply` the import will previewed.

Unfortunately there is no good way of locally demoing this as `local_file` does not support import.

```hcl
resource "aws_securityhub_account" "security_hub" {}

import {
  to = aws_securityhub_account.security_hub
  id = "012345678901"
}
```

```shell
❯ terraform plan
...
  # aws_securityhub_account.security_hub will be imported
    resource "aws_securityhub_account" "security_hub" {
        arn                       = "...:hub/default"
        auto_enable_controls      = true
        control_finding_generator = "SECURITY_CONTROL"
        enable_default_standards  = false
        id                        = "012345678901"
    }

Plan: 1 to import, 0 to add, 0 to change, 0 to destroy.
```
