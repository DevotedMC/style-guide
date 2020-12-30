#!/usr/bin/env groovy

def call() {
    def allJob = env.JOB_NAME.tokenize('/') as String[];
    def projectName = allJob[1];
    archiveArtifacts artifacts: "target/${projectName}-*.jar", fingerprint: true
    dir ('/var/jenkins_home/repoStaging') {
      sh 'git add .'
      sh 'git commit -m "${projectName}"'
      sshagent(['d0b8e457-9b94-4222-bf26-a4657960c6d7']) {
        sh 'git push'
      }
    }
}