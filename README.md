This project demonstrates a full end-to-end CI/CD workflow on AWS.

The goal is to simulate a real-world production-like deployment process:

Infrastructure provisioning → Container build → Deployment → Logging → Cloud storage.

🏗 Architecture Overview

Terraform provisions an EC2 instance.

A Docker image is built for a Python application.

The CI/CD pipeline deploys the container to EC2.

The application runs inside Docker.

Application logs are uploaded to S3 for persistence.

🛠 Tech Stack

AWS (EC2, S3, IAM)

Terraform (Infrastructure as Code)

Docker

Python

CI/CD (Jenkins / GitHub Actions / etc.)

📁 Project Structure
.
├── terraform/
│   ├── main.tf
│   ├── variables.tf
│   └── outputs.tf
│
├── app/
│   ├── app.py
│   └── requirements.txt
│
├── Dockerfile
├── pipeline/ (optional - depends on your CI tool)
└── README.md
⚙️ How It Works
1️⃣ Provision Infrastructure

Terraform creates:

EC2 instance

Security Group

IAM Role (if configured)

S3 bucket (for logs)

Run:

cd terraform
terraform init
terraform plan
terraform apply
2️⃣ Build Docker Image
docker build -t python-app .
3️⃣ Run Container Locally (Optional)
docker run -p 5000:5000 python-app
4️⃣ CI/CD Flow

The pipeline performs:

Checkout code

Terraform apply (or validate)

Docker build

Push (optional, if using ECR)

SSH into EC2

Deploy container

Upload logs to S3

📦 Logging to S3

The application generates a log file.
A script (or pipeline step) uploads it to S3:

aws s3 cp app.log s3://your-bucket-name/

This simulates production-style centralized log storage.

🎯 Learning Goals

This project focuses on:

Understanding Infrastructure as Code

Automating deployments

Working with containers in cloud environments

Managing cloud resources securely

Designing a clean CI/CD flow

🔐 Future Improvements

Add automated tests in pipeline

Use ECR instead of local Docker build

Add monitoring (Prometheus / CloudWatch)

Use Auto Scaling Group instead of single EC2

Store Terraform state remotely (S3 + DynamoDB)

👨‍💻 Why I Built This

The purpose of this project is to deeply understand the full lifecycle of deploying an application to the cloud — not just running a server, but managing infrastructure, containers, and deployment automation as a complete system.




Architecture 



           +-------------------+
           |   Git Repo (Code) |
           +---------+---------+
                     |
                     v
           +-------------------+
           |   CI/CD Pipeline   |
           | (Jenkins/GH Actions|
           +----+----------+----+
                |          |
     terraform apply       | docker build
                |          |
                v          v
        +-------------------------+
        | AWS Infrastructure      |
        |  - EC2                 |
        |  - Security Group      |
        |  - IAM Role/Policy     |
        +------------+------------+
                     |
                     v
        +-------------------------+
        | EC2 Instance            |
        |  - Docker runtime       |
        |  - Runs Python container|
        +------------+------------+
                     |
          writes logs to file (app.log)
                     |
                     v
        +-------------------------+
        | S3 Bucket (Logs)        |
        |  - store app.log        |
        +-------------------------+
