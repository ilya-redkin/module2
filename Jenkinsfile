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
    }
}