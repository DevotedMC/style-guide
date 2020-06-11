#!/usr/bin/env groovy

def call() {
	if (env.BRANCH_NAME == 'master') {
		String [] subPlugins = env.civ_dependent_plugins.split(' ');
		for(String pluginName : subPlugins) {
			if (pluginName != '') {
				build job: '../' + pluginName + '/master', wait: false
			}
		}
	}
}
