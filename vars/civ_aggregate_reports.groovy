#!/usr/bin/env groovy

def call() {
	def java = scanForIssues tool: java()
	def javadoc = scanForIssues tool: javaDoc()
	publishIssues issues: [java, javadoc]
	def checkstyle = scanForIssues tool: checkStyle(pattern: '**/target/checkstyle-result.xml')
	publishIssues issues: [checkstyle]
	def spotbugs = scanForIssues tool: spotBugs(pattern: '**/target/findbugsXml.xml')
	publishIssues issues: [spotbugs]
	def maven = scanForIssues tool: mavenConsole()
	publishIssues issues: [maven]
}
