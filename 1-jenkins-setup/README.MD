# Project 2: Terraform and Jenkins Integration

## Overview

This repository contains code and configuration files for Project 2, which focuses on integrating Terraform and Jenkins for infrastructure provisioning and continuous integration. The goal of this project is to automate the deployment of infrastructure using Terraform and establish a CI/CD pipeline with Jenkins.

## Table of Contents

- [Prerequisites](#prerequisites)
- [Getting Started](#getting-started)
- [Folder Structure](#folder-structure)
- [Usage](#usage)
- [Jenkins Pipeline](#jenkins-pipeline)
- [Contributing](#contributing)
- [License](#license)

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

3. Follow the usage instructions to set up and deploy infrastructure.

## Folder Structure

The project structure is organized as follows:

- `terraform/`: Contains Terraform configuration files for provisioning infrastructure.
- `jenkins/`: Includes Jenkins pipeline code and configuration files.
- `scripts/`: Houses any additional scripts or utility files needed for the project.

## Usage

Follow these steps to deploy the infrastructure using Terraform:

1. Navigate to the `terraform/` directory:

```bash
cd terraform/
```

2. Initialize Terraform:

```bash
terraform init
```

3. Review and modify the `variables.tf` file to customize the configuration.

4. Run Terraform to create the infrastructure:

```bash
terraform apply
```

Follow the Jenkins pipeline section to set up the CI/CD pipeline for this project.

## Jenkins Pipeline

The Jenkins pipeline is defined in the `Jenkinsfile` in the `jenkins/` directory. This pipeline automates the build, test, and deployment processes. Ensure that your Jenkins server is properly configured, and the required plugins are installed.

1. Create a new Jenkins pipeline job.
2. Configure the pipeline to point to the repository and use the `Jenkinsfile`.
3. Run the Jenkins job to trigger the pipeline.

## Contributing

If you would like to contribute to this project, please follow these guidelines:

1. Fork the repository.
2. Create a new branch for your feature or bug fix.
3. Make your changes and test thoroughly.
4. Create a pull request, describing the changes and any additional steps to test.

## License

This project is licensed under the [MIT License](LICENSE). Feel free to use, modify, and distribute the code as needed.

For more information, see the full [License](LICENSE) file.

---

Feel free to contact the project owner, [azamsajjad](https://github.com/azamsajjad), for any questions or issues related to this project. Thank you for your interest and contributions!