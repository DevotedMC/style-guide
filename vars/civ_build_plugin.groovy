#!/usr/bin/env groovy

def call() {
	if (env.BRANCH_NAME.startsWith('PR')) {
		sh 'mvn -U clean package -P civ-jenkins'
	} 
	else {
		sh 'mvn -U clean install -P civ-jenkins'
	} 
}

