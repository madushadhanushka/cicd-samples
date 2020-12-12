pipeline {
    agent {
        docker { image 'ballerina/ballerina:swan-lake-preview7' }
    }
    stages {
        stage('Initialize'){
        def dockerHome = tool 'myDocker'
        env.PATH = "${dockerHome}/bin:${env.PATH}"
        }
        stage('Test') {
            steps {
                sh 'ballerina -v'
            }
        }
    }
}