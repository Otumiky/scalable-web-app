# Scalable Web Application Deployment with Terraform

This project demonstrates the deployment of a scalable web application on AWS using Terraform. The infrastructure is modular, reusable, and adheres to best practices for Infrastructure as Code (IaC).

## Features

### Modular Approach
The infrastructure is organized into modules for better manageability and reusability:

- **VPC Module:** Creates a Virtual Private Cloud with subnets spread across availability zones.
- **EC2 Module:** Provisions instances with automated server setup using user data scripts.
- **ELB Module:** Configures an Elastic Load Balancer for distributing traffic evenly.
- **ASG Module:** Implements Auto Scaling Groups to handle varying traffic loads.

### Automation
- Uses user data scripts for server provisioning and setup.
- Automates Apache installation and web page hosting.

### State Management
- S3 backend with DynamoDB is used for reliable and collaborative Terraform state storage.

### Scalability
- Auto Scaling Groups ensure that the application dynamically adjusts to traffic demands.

---

## Prerequisites

1. Terraform installed on your local machine.
2. AWS CLI configured with appropriate credentials.
3. An AWS account.

---

## Project Structure

```
project-root/
├── modules/
|   ├── vpc/       # VPC module
|   ├── ec2/       # EC2 module
|   ├── elb/       # ELB module
|   ├── asg/       # ASG module
├── envs/
|   └── scripts/   # User data scripts
└── dev/
|   ├── main.tf         # Root Terraform configuration
|   ├── variable.tf
|   ├── backend.tf
|   ├── output.tf
|   ├── terraform.tfvars

```

---
## Architectural Diagram
![Alt text](https://github.com/Otumiky/scalable-web-app/blob/main/project-root/asgwebserver.drawio%20(2).png)

## Usage

### 1. Clone the Repository
```bash
git clone <repository-url>
cd project-root
```

### 2. Initialize Terraform
```bash
terraform init
```

### 3. Validate Configuration
```bash
terraform validate
```

### 4. Plan the Infrastructure
```bash
terraform plan
```

### 5. Deploy the Infrastructure
```bash
terraform apply
```

---

## Key Variables

| Variable       | Description                        | Default Value |
|----------------|------------------------------------|---------------|
| `ami_id`       | AMI ID for EC2 instances           | None          |
| `instance_type`| Instance type for EC2 and ASG      | t2.micro      |
| `vpc_cidr`     | CIDR block for the VPC            | 10.0.0.0/16   |

---

## Outputs

The project provides the following outputs:

- **ELB DNS:** DNS name of the Elastic Load Balancer.

![Alt text](https://github.com/Otumiky/scalable-web-app/blob/main/project-root/modular1.png)


![Alt text](https://github.com/Otumiky/scalable-web-app/blob/main/project-root/modular2.png)

---

## Cleanup

To destroy the infrastructure, run:
```bash
terraform destroy
```

---

## License

This project is licensed under the MIT License. See the `LICENSE` file for details.

---

## Acknowledgments

- Terraform: HashiCorp
- AWS Documentation

