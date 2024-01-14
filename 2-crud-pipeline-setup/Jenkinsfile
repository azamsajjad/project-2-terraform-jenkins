pipeline {
    agent any
    parameters {
        booleanParam(name: 'PLAN_TERRAFORM', defaultValue: false, description: 'Check to plan Terraform changes')
        booleanParam(name: 'APPLY_TERRAFORM', defaultValue: false, description: 'Check to apply Terraform changes')
        booleanParam(name: 'DESTROY_TERRAFORM', defaultValue: false, description: 'Check to destroy Terraform changes')
    }

    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'main'
                    url: 'https://github.com/azamsajjad/project-2-terraform-jenkins.git'
                sh "ls -lart"
            }
        }

        stage('Terraform Init') {
            steps {
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-credentials-rupert']]){
                    dir('2-crud-pipeline-setup/infra') {
                        sh 'echo "===========================TERRAFORM INIT=================================='
                        sh 'terraform init'
                    }
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                script {
                    if(params.PLAN_TERRAFORM) {
                        withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-credentials-rupert']]) {
                            dir('2-crud-pipeline-setup/infra') {
                                sh 'echo "=========================TERRAFORM PLAN========================="'
                                sh 'terraform plan'
                            }
                        }
                    }
                }
            }
        }

        stage {
            steps{
                script {
                    if (params.APPLY_TERRAFORM) {
                        withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-credentials-rupert']]){
                            dir('2-crud-pipeline-setup/infra') {
                                sh 'echo "=================Terraform Apply=================="'
                                sh 'terraform apply -auto-approve'                                
                            }
                        }
                    }
                }
            }
        }

        stage {
            steps {
                script {
                    if (params.DESTROY_TERRAFORM) {
                        withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-credentials-rupert']]){
                            dir('2-crud-pipeline-setup/infra') {
                                sh 'echo "==========================TERRAFORM DESTROY======================"'
                                sh 'terraform destroy -auto-approve'
                            }
                        }
                    }
                }
            }
        }
    }
}