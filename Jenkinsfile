pipeline {
    agent any

    stages {
        stage('Check directory content') {
            steps {
                echo 'Checking directory content'
                sh "pwd"
                sh "ls -al"
            }
        }
        stage('TF init') {
            steps {
                echo 'Initializing terraform...'
                sh 'terraform init'
            }
        }
        stage('TF validate') {
            steps {
                echo 'Validating terraform files...'
                sh 'terraform validate'
            }
        }
        stage('TF plan') {
            steps {
                echo 'Displaying terraform plan...'
                sh 'terraform validate'
            }
        }
        stage('TF deploy') {
            steps {
                echo 'Deploying terraform infrastructure...'
                sh 'terraform apply -auto-approve'
            }
        }
        stage('Reporting result') {
            steps {
                echo 'Terraform infrastructure has been deployed or updated'
            }
        }
    }
}