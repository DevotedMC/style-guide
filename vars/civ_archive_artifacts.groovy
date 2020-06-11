#!/usr/bin/env groovy

def call() {
    def allJob = env.JOB_NAME.tokenize('/') as String[];
    def projectName = allJob[1];
    archiveArtifacts artifacts: "target/${projectName}-*.jar", fingerprint: true
}