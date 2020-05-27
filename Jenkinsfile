pipeline {
    agent any
    tools {
        maven 'Maven 3.6.3'
        jdk 'Java 8'
    }
    stages {
        stage ('Build') {
            steps {
                withMaven() {
                    sh "mvn clean install -P jenkins"
                }
            }
        }
    }
}
