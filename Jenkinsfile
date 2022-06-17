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
                    def dockerCmd = 'docker-compose -f docker-compose.yaml up -d'
                    sshagent(['ec2-server2']) {
                        sh 'scp docker-compose.yaml  ec2-user@54.152.2.92:/home/ec2-user'
                        sh "ssh -o StrictHostKeyChecking=no ec2-user@54.152.2.92 ${dockerCmd}"
                    }
                }
            }
        }
    }
}


