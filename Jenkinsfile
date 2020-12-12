pipeline {
    agent {
        docker { image 'ballerina/ballerina:swan-lake-preview8' }
    }
    stages {
        stage('Test') {
            environment {
                docker_username = credentials('docker_username')
                docker_password = credentials('docker_password')
            }
            steps {
                sh 'pwd'
                sh 'ls -all'
                sh 'sudo ballerina build'
            }
        }
    }
}