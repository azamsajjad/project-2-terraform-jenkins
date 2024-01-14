terraform {
    backend "s3" {
        bucket = "devops-project-1-app-remote-state-bucket"
        key = "devops-project-1/terraform.tfstate"
        region = "us-west-1"
    }
}