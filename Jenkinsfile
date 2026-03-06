pipeline {
    agent any

    environment {
        AWS_DEFAULT_REGION = "ap-south-1"
    }

    stages {

        stage('Terraform Pipeline') {
            steps {
                withCredentials([[
                    $class: 'AmazonWebServicesCredentialsBinding',
                    credentialsId: 'f1bfbd85-84ce-404c-b069-1c91d0206b8b'
                ]]) {

                    checkout scm

                    bat 'terraform init'
                    bat 'terraform fmt -check'
                    bat 'terraform validate'
                    bat 'terraform plan'

                    input message: 'Approve Terraform Apply?'

                    bat 'terraform apply -auto-approve'
                }
            }
        }
    }

    post {
        success {
            echo 'Terraform deployment completed successfully.'
        }

        failure {
            echo 'Pipeline failed. Check logs.'
        }
    }
}