# Terraform tools

General regarding tools: Configure them sooner rather than later...

## tfenv .terraform-version

[Terraform versioning](https://github.com/tfutils/tfenv)

Create `.terraform-version` containing the version number in each directory containing Terraform code.
`terraform` commands will automatically use the version specified. This leads to less broken code when
something is automatically updated.

[Example .terraform-version](./.terraform-verison)

```shell
❯ tfenv list
* 1.5.7 (set by ...terraform-workshop/5-tools/.terraform-version)
  1.5.6
  1.5.4
  1.5.3
  1.3.6
  1.3.3
  1.3.0
  0.1
```

## Terraform format

Format your code! Make it easy to read and review

[Terraform fmt](https://developer.hashicorp.com/terraform/cli/commands/fmt)

```shell
terraform fmt
```

## Pre-commit

[Pre-commit website](https://pre-commit.com/)

Pipelines are good and all but giving instant feedback is better.
Run checks, scripts, verifications before code can be committed.

[Example .pre-commit](../.pre-commit-config.yaml)

```shell
# Install pre-commit for the current git repository
# Do this once
pre-commit install
```

Create and stage files!

```shell
# Git status. Poorly formatted main.tf file staged
❯ git status
On branch main
Changes to be committed:
  (use "git restore --staged <file>..." to unstage)
        new file:   main.tf


# Manually run pre-commit
❯ pre-commit run
[WARNING] Unstaged files detected.
check yaml...........................................(no files to check)Skipped
check json...........................................(no files to check)Skipped
check for merge conflicts................................................Passed
check for added large files..............................................Passed
check for case conflicts.................................................Passed
forbid new submodules................................(no files to check)Skipped
detect aws credentials...................................................Passed
detect private key.......................................................Passed
mixed line ending........................................................Passed
trim trailing whitespace.................................................Failed
- hook id: trailing-whitespace
- exit code: 1
- files were modified by this hook

Fixing 5-tools/main.tf

check that executables have shebangs.................(no files to check)Skipped
fix end of files.........................................................Failed
- hook id: end-of-file-fixer
- exit code: 1
- files were modified by this hook

Fixing 5-tools/main.tf

Validate GitHub Actions..............................(no files to check)Skipped
Validate GitHub Workflows............................(no files to check)Skipped
Terraform fmt............................................................Failed
- hook id: terraform_fmt
- files were modified by this hook

main.tf

markdownlint.........................................(no files to check)Skipped
[WARNING] Stashed changes conflicted with hook auto-fixes... Rolling back fixes...
[INFO] Restored changes from /Users/donaldfagen/.cache/pre-commit/patch1698254546-33391.


# Check status of git
# Pre-commit has automatically fixed the issues it can
❯ git status
On branch main
Changes to be committed:
  (use "git restore --staged <file>..." to unstage)
        new file:   main.tf

Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git restore <file>..." to

# Stage fixed main.tf
❯ git add main.tf

# Rerun pre-commit
❯ pre-commit run
check yaml...........................................(no files to check)Skipped
check json...........................................(no files to check)Skipped
check for merge conflicts................................................Passed
check for added large files..............................................Passed
check for case conflicts.................................................Passed
forbid new submodules................................(no files to check)Skipped
detect aws credentials...................................................Passed
detect private key.......................................................Passed
mixed line ending........................................................Passed
trim trailing whitespace.................................................Passed
check that executables have shebangs.................(no files to check)Skipped
fix end of files.........................................................Passed
Validate GitHub Actions..............................(no files to check)Skipped
Validate GitHub Workflows............................(no files to check)Skipped
Terraform fmt............................................................Passed
markdownlint.........................................(no files to check)Skipped
```

Not just for Terraform!

## Checkov

[Checkov](https://www.checkov.io/)

Checkov scans cloud infrastructure configurations to find misconfigurations before they're deployed.

Helps developers to notice incorrectly configured resources **before** someone reviews the code.

[Checkov Terraform policies](https://www.checkov.io/5.Policy%20Index/terraform.html)

### AWS Security Group demo

```hcl
resource "aws_security_group" "unsecure" {
  name        = "unsecure"
  description = "Be very unsecure"
  vpc_id      = aws_vpc.main.id

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
}
```

```shell
❯ checkov --directory . --quiet
terraform scan results:

Passed checks: 4, Failed checks: 2, Skipped checks: 0

Check: CKV2_AWS_5: "Ensure that Security Groups are attached to another resource"
        FAILED for resource: aws_security_group.unsecure
        File: /main.tf:1-12
        Guide: https://docs.paloaltonetworks.com/content/techdocs/en_US/prisma/prisma-cloud/prisma-cloud-code-security-policy-reference/aws-policies/aws-networking-policies/ensure-that-security-groups-are-attached-to-ec2-instances-or-elastic-network-interfaces-enis.html

                1  | resource "aws_security_group" "unsecure" {
                2  |   name        = "unsecure"
                3  |   description = "Be very unsecure"
                4  |   vpc_id      = aws_vpc.main.id
                5  |
                6  |   egress {
                7  |     from_port        = 0
                8  |     to_port          = 0
                9  |     protocol         = "-1"
                10 |     cidr_blocks      = ["0.0.0.0/0"]
                11 |   }
                12 | }

Check: CKV_AWS_23: "Ensure every security groups rule has a description"
        FAILED for resource: aws_security_group.unsecure
        File: /main.tf:1-12
        Guide: https://docs.paloaltonetworks.com/content/techdocs/en_US/prisma/prisma-cloud/prisma-cloud-code-security-policy-reference/aws-policies/aws-networking-policies/networking-31.html

                1  | resource "aws_security_group" "unsecure" {
                2  |   name        = "unsecure"
                3  |   description = "Be very unsecure"
                4  |   vpc_id      = aws_vpc.main.id
                5  |
                6  |   egress {
                7  |     from_port        = 0
                8  |     to_port          = 0
                9  |     protocol         = "-1"
                10 |     cidr_blocks      = ["0.0.0.0/0"]
                11 |   }
                12 | }
```
