# Terraform remote state

`Terraform remote state` is often used to get outputs created by one Terraform state and use that as variables in another.
A typical example is having one state for networking and one for compute. Compute needs the resource identifiers from
networking to create resources in the correct subnet.

```bash
1-backends/
  main.tf
  outputs.tf # Output resources
2-remote-state/
  main.tf    # Read and use resources
```

Example of a local remote state

```hcl
data "terraform_remote_state" "test_state" {
  backend = "local"

  config = {
    path = "path/to/remote/state/file.tfstate"
  }
}
```

## Demo

```bash
terraform init
terraform apply

# Open output demo file created by local_file.remote_state
code remote-state-outputs.demo.txt
```

What happens when a output is modified or deleted?

## DO NOT USE REMOTE STATE

Opinion: Do not rely on remote state. It will lead to:

1. Issues when an output changes
2. Secrets might be (accidentally) shared

Instead select an option for storing key/values, preferably one that is version controlled and allow granular access control

* [AWS Secrets Manager](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret_version)
* [AWS SSM Parameter](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter)
* [HashiCorp Vault Secret](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret_version)

## Challenge

You have full access the remote state in this example, which is often the case when referring to a remote state

Crack the elite four digit password

```bash
terraform apply -var hacker_mode_password=XXXX

# Open remote state file
code remote-state-outputs.demo.txt
```

What is hiding around line 100?
