pipeline {
    agent any
    tools {
        nodejs 'nodejs'
    }
    parameters {
        choice(name:'VERSION', choices:['1.0', '1.1', '1.2'], description:'Choose the version of the project')

        booleanParam(name :'executeTests', description:'Execute the tests', defaultValue:false)
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
        stage('Build Image') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'docker-hub-repo', passwordVariable: 'PASS', usernameVariable: 'USER')]) {
                    sh 'docker build -t jennykibiri/freestyle-jenkins-node-app .'
                    sh "echo $PASS | docker login -u $USER --password-stdin"
                    sh 'docker push jennykibiri/freestyle-jenkins-node-app'
                }
            }
        }
        stage ('Deploy') {
            steps {
                script {
                    def dockerCmd = 'docker run  -p 3000:3000 -d jennykibiri/freestyle-jenkins-node-app:latest'
                    sshagent(['ec2-server2']) {
                        sh "ssh -o StrictHostKeyChecking=no ec2-user@54.152.2.9 ${dockerCmd}"
                    }
                }
            }
        }
    }
}
