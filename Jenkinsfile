pipeline {
    agent any
    tools {
        nodejs "nodejs"
    }
    stages {
        stage('Build') {
            steps {
                sh 'npm install'
                sh 'npm run build'

            }
        }
        stage('Test') {
            steps {
                sh 'npm run test'
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying....'
            }
        }
    }
}
