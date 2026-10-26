# Terraform AWS Infrastructure — Workspaces & Modules

A hands-on **Infrastructure as Code (IaC)** project that uses **Terraform** to manage AWS infrastructure across **Development, UAT/Staging, and Production** environments.

The project uses reusable Terraform modules for **Amazon EC2, Amazon S3, and Amazon DynamoDB**, with environment-specific configuration to help keep infrastructure organized and consistent.

## Architecture

<!-- Update the architecture image so it shows DynamoDB instead of RDS, then save it at this path. -->
![Terraform AWS environments architecture](docs/terraform-aws-environments.png)

> **Diagram note:** The current diagram should be updated to show **DynamoDB** in place of **RDS** so it matches the modules used by this project.

## Environments

| Environment | Workspace | Purpose | Modules |
|---|---|---|---|
| Development | `dev` | Build and test changes | EC2, S3, DynamoDB |
| UAT / Staging | `uat` | Validate changes before release | EC2, S3, DynamoDB |
| Production | `prd` | Run production workloads | EC2, S3, DynamoDB |

Resource counts and settings can differ by environment according to the requirements and cost limits.

## Terraform Modules

- **EC2 module** — provisions and configures Amazon EC2 instances.
- **S3 module** — provisions Amazon S3 buckets for object storage.
- **DynamoDB module** — provisions Amazon DynamoDB tables. DynamoDB can also be used for Terraform state locking when configured appropriately for the backend/version in use.

Modules help keep resource definitions reusable and reduce repeated Terraform code across environments.

## Key Concepts Demonstrated

- **Infrastructure as Code:** Define AWS infrastructure in version-controlled Terraform configuration.
- **Terraform Workspaces:** Maintain separate Terraform state instances for environments when using a workspace-based approach.
- **Reusable modules:** Organize EC2, S3, and DynamoDB resources into reusable components.
- **Environment-specific configuration:** Adjust resource counts and settings for `dev`, `uat`, and `prd`.
- **Remote state:** Configure an Amazon S3 backend to store Terraform state centrally, if enabled in this project.
- **Plan before apply:** Review infrastructure changes before applying them.

## Example Repository Structure

Your actual filenames may differ; adjust this example to match your repository:

```text
.
├── main.tf
├── provider.tf
├── variables.tf
├── outputs.tf
├── terraform.tf
├── environments/
│   ├── dev.tfvars
│   ├── uat.tfvars
│   └── prd.tfvars
├── modules/
│   ├── ec2/
│   ├── s3/
│   └── dynamodb/
└── docs/
    └── terraform-aws-environments.png
```

## Prerequisites

- An AWS account
- Terraform CLI installed
- AWS credentials configured using an approved method, such as an AWS CLI profile or an attached IAM role
- Appropriate IAM permissions for the resources you intend to manage

**Security:** Do not commit AWS access keys, private keys, `.tfstate` files, `.terraform/`, or secret `.tfvars` files to GitHub. Add them to `.gitignore`. Commit Terraform source files and safe example configuration instead.

## Getting Started

### 1. Clone the repository

```bash
git clone <YOUR_GITHUB_REPOSITORY_URL>
cd <YOUR_REPOSITORY_DIRECTORY>
```

Replace the placeholders with your repository URL and directory name.

### 2. Initialize Terraform

Run this from the directory containing the root Terraform configuration:

```bash
terraform init
```

### 3. Select or create a workspace

List available workspaces:

```bash
terraform workspace list
```

Select an existing workspace or create one:

```bash
terraform workspace select dev
# If it does not exist:
terraform workspace new dev
```

Repeat for `uat` and `prd` as needed.

> **Important:** Workspaces separate Terraform state; they do not automatically isolate AWS accounts, regions, permissions, or resource names. Confirm that the configuration maps each workspace to the intended environment before deploying.

### 4. Format, validate, and plan

```bash
terraform fmt -recursive
terraform validate
terraform plan
```

If your repository includes environment variable files, plan with the relevant file, for example:

```bash
terraform plan -var-file="environments/dev.tfvars"
```

Use this command only if that file exists and is configured for your project.

### 5. Apply changes

After reviewing the plan and confirming the target AWS account, region, workspace, and expected cost:

```bash
terraform apply
```

For production, follow an appropriate review and approval process before applying changes.

### 6. Destroy practice resources (optional)

For a disposable practice environment, select the correct workspace and review the proposed changes first:

```bash
terraform plan -destroy
terraform destroy
```

Do not destroy shared or production infrastructure unless you are authorized and have confirmed the impact.

## Typical Workflow

1. Select the target environment.
2. Update module inputs or environment-specific variables.
3. Run `terraform fmt` and `terraform validate`.
4. Review `terraform plan`.
5. Apply only after checking the proposed changes.
6. Verify the created resources and outputs in AWS.
7. Commit Terraform source changes to GitHub, excluding state files and secrets.

## Learning Outcomes

- Creating reusable Terraform modules for EC2, S3, and DynamoDB
- Organizing environment-specific infrastructure
- Understanding Terraform workspaces and state separation
- Using Terraform's plan/apply workflow to manage AWS resources
- Applying safer GitHub version-control practices to IaC projects

## Disclaimer

This is a learning project. Before using it for real workloads, review IAM permissions, networking, state storage, backups, resource naming, and estimated AWS charges. The actual resources created depend on the Terraform code in this repository.
