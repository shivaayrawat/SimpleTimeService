# SimpleTimeService

## Task 1 - Minimalist Application Development / Docker / Kubernetes

### SimpleTimeService - A Simple Microservice in Python

#### Purpose
The **SimpleTimeService** is a lightweight microservice built using Flask. It returns a JSON response that includes:
- **IP address of the client making the request**
- **Current timestamp**

This service is built as a Docker container to ensure easy deployment across different environments.

---

## Prerequisites

Before you begin, ensure that you have the following tools installed:

#### 1. **Docker**
Docker is needed to build, run, and manage containers.
- **Installation Guide**: [Docker Installation](https://docs.docker.com/get-docker/)
- Verify installation:
  ```sh
  docker --version
2. Git
Git is needed to clone the repository to your local machine.

Installation Guide: Git Installation
Verify installation:
sh
Copy
Edit
git --version
Clone the Repository
To get started, clone the repository to your local machine:

sh
Copy
Edit
git clone https://github.com/shivaayrawat/SimpleTimeService.git
Navigate into the project directory:

sh
Copy
Edit
cd SimpleTimeService
Build the Docker Image
Once you've cloned the repository, you can build the Docker image using the following command:

sh
Copy
Edit
docker build -t simple-time-service .
-t simple-time-service tags the image with the name simple-time-service.
This command may take a few minutes as it pulls the necessary dependencies.
Run the Docker Container
Once the image is built, you can run the Docker container. This will start the application on port 5000.

To run the container in the background:

sh
Copy
Edit
docker run -d -p 5000:5000 simple-time-service
-d runs the container in detached mode (in the background).
-p 5000:5000 binds port 5000 of the container to port 5000 on your local machine.
Access the Application
After the container is running, you can access the SimpleTimeService by navigating to the following URL in your web browser:

📌 URL: http://localhost:5000

The response will be a JSON object that includes the timestamp and IP address of the client:

json
Copy
Edit
{
  "ip": "160.191.123.133",
  "timestamp": "2025-01-31T14:45:00.123456"
}
Stopping the Container
To stop the running container, use the following command to find the container ID:

sh
Copy
Edit
docker ps
This will display the currently running containers. Look for the container with the image name simple-time-service, and note the container ID.

Stop the container with:

sh
Copy
Edit
docker stop <container_id>
Replace <container_id> with the actual container ID.

DockerHub Image
The SimpleTimeService Docker image has been published to DockerHub. You can pull the latest version directly from DockerHub by using the following command:

sh
Copy
Edit
docker pull 945shivamrawat/simple-time-service:latest
Task 2 - Terraform and Cloud Infrastructure Setup
Purpose
The goal of Task 2 is to set up infrastructure in AWS using Terraform to host the SimpleTimeService containerized application. This infrastructure includes a VPC, subnets, ECS service, load balancer, and other AWS resources.

Prerequisites
1. Terraform
Terraform is needed to provision infrastructure in AWS.

Installation Guide: Terraform Installation
Verify installation:
sh
Copy
Edit
terraform --version
2. AWS Account
Ensure you have an AWS account to create the necessary infrastructure.

3. AWS CLI
AWS CLI is used to interact with AWS services from your local machine.

Installation Guide: AWS CLI Installation
Verify installation:
sh
Copy
Edit
aws --version
AWS Configuration for Terraform
Create an IAM User:

Log in to the AWS Management Console.
Go to IAM > Users > Add User.
Provide a name (e.g., terraform-user) and select Programmatic access.
Attach the AdministratorAccess policy to the user.
Download the Access Key ID and Secret Access Key.
Configure AWS CLI: Use the Access Key ID and Secret Access Key to configure the AWS CLI:

sh
Copy
Edit
aws configure
Provide the following details when prompted:

AWS Access Key ID
AWS Secret Access Key
Default region (e.g., us-east-1)
Default output format: json
Create an S3 Bucket and DynamoDB Table for Terraform State: Terraform requires a backend to store its state file.

Create an S3 bucket:

sh
Copy
Edit
aws s3api create-bucket --bucket <your-bucket-name> --region <your-region>
Replace <your-bucket-name> and <your-region> with appropriate values.

Enable versioning for the bucket:

sh
Copy
Edit
aws s3api put-bucket-versioning --bucket <your-bucket-name> --versioning-configuration Status=Enabled
Create a DynamoDB table:

sh
Copy
Edit
aws dynamodb create-table --table-name <your-table-name> \
  --attribute-definitions AttributeName=LockID,AttributeType=S \
  --key-schema AttributeName=LockID,KeyType=HASH \
  --billing-mode PAY_PER_REQUEST
Replace <your-table-name> with an appropriate value (e.g., terraform-lock-table).

Update the Terraform Backend: Update the backend.tf file with the following configuration:

hcl
Copy
Edit
terraform {
  backend "s3" {
    bucket         = "<your-bucket-name>"
    key            = "terraform/state"
    region         = "<your-region>"
    dynamodb_table = "<your-table-name>"
  }
}
Replace <your-bucket-name>, <your-region>, and <your-table-name> with the values you created earlier.

Infrastructure Setup with Terraform
Initialize Terraform: Navigate to the Terraform/ directory and initialize Terraform:

sh
Copy
Edit
terraform init
Validate the Configuration: Validate the Terraform configuration files:

sh
Copy
Edit
terraform validate
Plan the Infrastructure: Generate a plan to see what resources will be created:

sh
Copy
Edit
terraform plan
Apply the Configuration: Apply the Terraform configuration to create the infrastructure:

sh
Copy
Edit
terraform apply
Confirm the changes by typing yes when prompted.

Accessing the Application
Once the infrastructure is deployed, the load balancer's DNS name will be provided as an output.

📌 Access the application using the load balancer URL. The response will include the timestamp and IP address in JSON format:

json
Copy
Edit
{
  "ip": "160.191.123.133",
  "timestamp": "2025-01-31T14:45:00.123456"
}
Clean Up
To destroy the resources created by Terraform:

sh
Copy
Edit
terraform destroy
Confirm the destruction by typing yes when prompted.

Repository Structure
bash
Copy
Edit
SimpleTimeService/
├── README.md                # Documentation for the project
├── Dockerfile               # Dockerfile for SimpleTimeService
├── app/                     # Application source code
│   └── app.py               # Flask application
├── Terraform/               # Terraform configuration files
│   ├── backend.tf           # Backend configuration for Terraform state
│   ├── main.tf              # Main Terraform resources
│   ├── outputs.tf           # Terraform output values
│   ├── variables.tf         # Input variables for Terraform
│   └── terraform.tfvars     # Variable values
└── .gitignore               # Files and folders to ignore in Git
Notes
Ensure that you do not commit sensitive information like AWS keys to the repository.
Use .gitignore to exclude files such as .terraform/ and terraform.tfstate.
vbnet
Copy
Edit
