# env-dev-free-tier

## Overview

`env-dev-free-tier` is the root Terraform environment repository responsible for deploying the infrastructure for the **Free-Tier EC2 Baseline with SSM project**.

This repository orchestrates the infrastructure by consuming two Terraform modules:

* `tf-mod-vpc-min`
* `tf-mod-ec2-ssm`

The infrastructure is deployed using a **Jenkins CI/CD pipeline**.

---

## Infrastructure Components

The deployment provisions:

* VPC
* Public Subnet
* Internet Gateway
* Route Table
* EC2 Instance (t3.micro)
* IAM Role for SSM
* Security Group (no SSH)

---

## Architecture

```text
GitHub Repositories
│
├── tf-mod-vpc-min
├── tf-mod-ec2-ssm
└── env-dev-free-tier
        │
        ▼
     Jenkins Pipeline
        │
        ▼
     Terraform Apply
        │
        ▼
     AWS Infrastructure
   ├── VPC
   ├── Public Subnet
   └── EC2 (SSM Access)
```

---

## Terraform Backend

Terraform state is stored remotely in an S3 bucket.

Example backend configuration:

```hcl
terraform {
  backend "s3" {
    bucket = "harit-terraform-state-ap-south-1"
    key    = "env-dev-free-tier/terraform.tfstate"
    region = "ap-south-1"
  }
}
```

Optional: DynamoDB table can be used for state locking.

---

## Jenkins Pipeline

Infrastructure is deployed through Jenkins.

Pipeline stages:

```text
terraform fmt
terraform validate
terraform plan
manual approval
terraform apply
```

The pipeline is defined in:

```
Jenkinsfile
```

---

## Deployment Workflow

1. Developer pushes code to GitHub.
2. Jenkins pipeline is triggered.
3. Terraform initializes backend.
4. Infrastructure plan is generated.
5. Manual approval step confirms deployment.
6. Terraform applies infrastructure changes.

---

## Repository Structure

```text
env-dev-free-tier
│
├── main.tf
├── backend.tf
├── variables.tf
├── Jenkinsfile
└── README.md
```

---

## Validation

After deployment, access the EC2 instance via AWS CLI:

```bash
aws ssm start-session --target <instance-id>
```

Run inside the instance:

```bash
uname -a
```

This confirms that the instance is accessible via **SSM Session Manager without SSH**.

---

## Project Goal

This repository demonstrates a **reproducible Terraform deployment with CI/CD automation** for AWS infrastructure while following security best practices.
