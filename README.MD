![Screenshot](overview.jpg)

# Project 2: Terraform Jenkins Integration

Welcome to the Project 2 repository for Terraform Jenkins Integration. This project is designed to guide you through setting up an infrastructure using Terraform and integrating Jenkins for continuous integration. The goal of this project is to automate the deployment of infrastructure using Terraform and establish a CI/CD pipeline with Jenkins. Follow the steps outlined below to successfully implement the project.

## Table of Contents
- [Introduction](#introduction)
- [Prerequisites](#Prerequisites)
- [Getting Started](#getting-started)
- [Steps](#steps)
  1. [Step 1: Jenkins Setup (Infrastructure Provisioning with Terraform)](#step-1-infrastructure-provisioning-with-terraform)
  2. [Step 2: Jenkins Configuration (Pipline Setup) and Infrastructure Provisioning for Application](#step-2-jenkins-pipeline-configuration-and-infrastructure-provisioning-for-application)
  3. [Step 3: Application Code](#step-3-application-code)
- [Usage](#usage)
- [Contributing](#contributing)
- [License](#license)

## Introduction

This project focuses on setting up a basic infrastructure using Terraform and integrating Jenkins for continuous integration. The repository is structured to guide you through the process with three main steps, each outlined in a dedicated folder.


## Prerequisites

Before you begin, ensure you have the following prerequisites:

- [Terraform](https://www.terraform.io/) installed on your local machine.
- [Jenkins](https://www.jenkins.io/) server up and running.
- Jenkins plugins: Install necessary plugins such as Terraform, Git, etc., based on the requirements.
- AWS credentials: Configure AWS credentials with appropriate permissions for Terraform to provision infrastructure.

## Getting Started

1. Clone the repository to your local machine:

```bash
git clone https://github.com/azamsajjad/project-2-terraform-jenkins.git
```

2. Navigate to the project directory:

```bash
cd project-2-terraform-jenkins
```
## Steps
### Step 1: Infrastructure Provisioning with Terraform

Navigate to the [Step1_Jenkins_Setup](1-Jenkins_Setup/) folder for detailed instructions on provisioning infrastructure using Terraform. This step includes setting up the necessary infrastructure components such as virtual machines, networks, or any other resources required for this project. This step guides you through setting up Jenkins on your provisioned infrastructure and configuring it to integrate with your version control system.

1. Navigate to the `1-Jenkins_Setup/` directory:

```bash
cd 1-Jenkins_Setup/
```

2. Initialize Terraform:

```bash
terraform init
```

3. Review and modify the `variables.tf`and `terraform.tfvars`file to customize the configuration.

4. Run Terraform fmt to format the code:

```bash
terraform fmt
```

4. Run Terraform plan to validate the infrastructure:

```bash
terraform plan
```

4. Run Terraform to create the infrastructure:

```bash
terraform apply
```

Follow the Jenkins pipeline section to set up the CI/CD pipeline for this project.

### Step 2: Jenkins Pipeline Configuration and Infrastructure Provisioning for Application

Move to the [Step2_Pipeline_Setup](2-Pipeline_Setup/) folder to find instructions on provisioning infrastructure for the application using Jenkinsfile. This step focuses on creating a Jenkins job that automates tasks such as building, testing, and deploying your application.

The Jenkins pipeline is defined in the `Jenkinsfile` in the `2-Pipeline_Setup/` directory. This pipeline automates the build, test, and deployment processes. Ensure that your Jenkins server is properly configured, and the required plugins are installed.

1. Create a new Jenkins pipeline job.
2. Configure the pipeline to point to the repository and use the `Jenkinsfile`.
3. Run the Jenkins job to trigger the pipeline.

### Step 3: Application Code

In the [Step3_Application_Code](3-Application_Code/) folder, you will find the application code itself. It is a basic CRUD REST API with Python Flask.

## Usage

Follow the steps outlined in each folder sequentially to successfully complete the project. Ensure that you have the necessary permissions and credentials before executing any commands. Detailed instructions and code snippets are provided in each folder.

## Contributing

If you would like to contribute to this project, please follow these guidelines:

1. Fork the repository.
2. Create a new branch for your feature or bug fix.
3. Make your changes and test thoroughly.
4. Create a pull request, describing the changes and any additional steps to test.

## License

This project is not licensed. Feel free to use, modify, and distribute the code as needed.

---

Feel free to contact the project owner, [azamsajjad](https://github.com/azamsajjad), for any questions or issues related to this project. Thank you for your interest and contributions!