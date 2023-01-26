pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                echo 'Building..',
                pwd, 
                ls -al
            }
        }
        stage('Test') {
            steps {
                echo 'Testing..'
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying....'
            }
        }
    }
}