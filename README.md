# Terraform AWS EC2 Deployment with GitHub Actions CI/CD

## 📌 Overview
This project automates the provisioning of **AWS EC2 instances** using **Terraform**, integrated with a **GitHub Actions CI/CD pipeline**.  
The workflow includes:
- **Terraform Init, Validate, Plan**
- **Artifact upload of the plan**
- **Manual approval before Apply** (using GitHub Environments)
- **Secure AWS credentials via GitHub Secrets**

---

## ✅ Features
- Infrastructure as Code (IaC) using **Terraform**
- **GitHub Actions CI/CD** for automated plan and controlled apply
- **Manual approval gate** for production deployments
- **Artifacted plan** ensures reviewers approve exactly what gets applied
- Supports **AWS backend with state locking** (S3 + DynamoDB recommended)

---

## 🏗 Architecture
- **Terraform** provisions EC2 instances in AWS.
- **GitHub Actions workflow**:
  - Runs on `push` to `main` and `pull_request`.
  - `plan` job runs for all events.
  - `apply` job runs only on `main` after manual approval.

---

## 📂 Project Structure
```
.
├── main.tf          # Terraform configuration for EC2
├── variables.tf     # Input variables
├── outputs.tf       # Outputs
├── provider.tf      # AWS provider configuration
├── terraform.tfvars # Variable values
└── .github/
    └── workflows/
        └── terraform.yml  # CI/CD pipeline
```

---

## 🚀 How to Use
### 1. Prerequisites
- AWS account with IAM user/role for Terraform.
- GitHub repository with:
  - `AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY`, `AWS_DEFAULT_REGION` in **Secrets**.
- Terraform installed locally (optional for manual runs).

### 2. Setup GitHub Environment
- Go to **Settings → Environments → prod**.
- Add **Required reviewers** for manual approval.
- Add environment-specific secrets if needed.

### 3. Run Workflow
- **Pull Request** → Runs `plan` only.
- **Push to main** → Runs `plan` → waits for **approval** → runs `apply`.

---

## ✅ Real Outputs from Successful Apply
After manual approval, Terraform applied successfully:

```
Apply complete! Resources: 4 added, 0 changed, 0 destroyed.

Outputs:

instance_id       = "i-07d1d355e941b5234"
instance_public_ip = "3.111.198.183"
private_key_pem    = <sensitive>
ssh_command        = "ssh -i ~/.ssh/harsha-key ec2-user@3.111.198.183"
```

---

## 🔑 Connect to Your EC2 Instance
1. Save the private key from Terraform output to `~/.ssh/harsha-key` and set permissions:
   ```bash
   chmod 400 ~/.ssh/harsha-key
   ```
2. SSH into the instance:
   ```bash
   ssh -i ~/.ssh/harsha-key ec2-user@3.111.198.183
   ```

---

## 🛡 Best Practices
- Use **remote backend** (S3 + DynamoDB) for state.
- Enable **state locking**.
- Use **least privilege IAM role** for CI/CD.
- Consider **OIDC authentication** for GitHub Actions.

---

## 📜 License
MIT License (or your preferred license).
