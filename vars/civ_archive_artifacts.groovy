#!/usr/bin/env groovy

def call() {
    def allJob = env.JOB_NAME.tokenize('/') as String[];
    def projectName = allJob[1];
    archiveArtifacts artifacts: "target/${projectName}-*.jar", fingerprint: true
    dir ('/var/jenkins_home/repoStaging') {
      sh 'git add .'
      sh 'git commit -m \\"${projectName}\\"'
      sshagent(['civclassic-bot-ssh-key']) {
        sh 'git push origin master:master'
      }
    }
}