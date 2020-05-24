pipeline {
    agent any
    tools {
        maven 'Maven latest'
        jdk 'OpenJDK 11'
    }
    stages {
        stage ('Initialize') {
            steps {
                sh '''
                    echo "PATH = ${PATH}"
                    echo "M2_HOME = ${M2_HOME}"
                '''
            }
        }

        stage ('Build') {
            steps {
                withMaven() {
                    sh "mvn"
                }
            }
        }
    }
}