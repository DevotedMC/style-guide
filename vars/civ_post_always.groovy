#!/usr/bin/env groovy

def call() {
     withCredentials([string(credentialsId: 'civclassic-discord-webhook', variable: 'DISCORD_WEBHOOK')]) {
                discordSend description: "Build: [${currentBuild.id}](${env.BUILD_URL}) **||**  Status: ${currentBuild.currentResult} **||**  [**LOG**](${env.BUILD_URL}consoleFull)\n**Checkstyle warnings:** ${tm('$ANALYSIS_ISSUES_COUNT')}\n", footer: 'Civclassic Jenkins', link: env.BUILD_URL, successful: currentBuild.resultIsBetterOrEqualTo('SUCCESS'), title: "${env.JOB_NAME} #${currentBuild.id}", webhookURL: DISCORD_WEBHOOK            
    }
}
