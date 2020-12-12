pipeline {
    agent {
        docker { image 'ballerina/ballerina:swan-lake-preview7' }
    }
    stages {
        stage('Test') {
            steps {
                sh 'ballerina -v'
            }
        }
    }
}