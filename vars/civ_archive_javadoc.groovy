#!/usr/bin/env groovy

def call() {
	if (env.BRANCH_NAME == 'master') {
		step([$class: 'JavadocArchiver', javadocDir: 'target/apidocs', keepAll: false])
	}
}