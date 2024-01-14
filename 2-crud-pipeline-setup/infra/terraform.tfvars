vpc_cidr             = "12.0.0.0/16"
vpc_name             = "devops-project-us-west-1-vpc"
cidr_public_subnet   = ["12.0.1.0/24", "12.0.2.0/24"]
cidr_private_subnet  = ["12.0.3.0/24", "12.0.4.0/24"]
us_availability_zone = ["us-west-1a", "us-west-1b"]
public_key           = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDvh0Qjtk+T+oWjXxrkNgeJ7LaBho42beFdMPU1vIc+o3YYwQneJfqWKAYPcz9dZGBHSD3pnCpJq0oJNZ/bnUb02gRXl745oNJnyDALpVg1QsELGLiw7pMORdhky5Z/6Tct/+7Okft2ddhWJucLlFLqJEifX4KIcDgS9loOhTE/dTxzW9qRjCyMRKPIhQKZvEVXvLbu+uBUQEJyciR+RKl6StJ/svzZbA3FQU7LFDcGAaeNa2r4ZNiqmnOGGySiJrr/PMccBdjFEFHJ1Bm7JgNHUX2ejp9AO8nxvsgJWQlL7laa4ts+v1UynfJSQSrdhib5gTDO+puNbLvZyIGjZkE7obAoJ7mkhYxtbpPYrd1IVLxyaHMNQjgoIbHiPgN31y6fVaBDKewYmohDHxcNU8YxKdrJU9pFzVtUKwov6qXv041G9exWfOriyaL1aDMS+q4vVSW/5mGDN8nmDpD+loS1OkezYb3QyOR3KjdSSBxSWTQS/yZegKI9QHV1JWDNaeU= devops@T480"

ami_image_name = "ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"
ami_owner_name = "099720109477"


bucket_name = "devops-project-1-app-remote-state-bucket-west"
name        = "environment"
environment = "dev-1"
domain_name = "app.azamsajjad.com"