#!/usr/bin/env bash

#Assumes Java, Maven and git are installed. If you haven't done that yet, see https://github.com/CivClassic/style-guide/tree/master/GettingStarted#setting-up-your-development-environment
#You also need curl if your distribution doesn't already include it

#You can uncomment this line on Debian/Ubuntu to install everything needed, except for java
#sudo apt-get install curl git maven

#You will need to have a global username and email set in your git install. If you haven't already done this, use the following commands
# git config --global user.email "you@example.com"
# git config --global user.name "Your Name"


#Change these variables as needed

#Directory we are basing in, defaulting to the current one
currentDir=$(pwd)

#Name of the folder to put all plugins in
folderName='civ'

#Use Github URLs in the form of git@github.com, which require SSH keys? If set to false, uses normal https
useSSH='true'

#List of Git remote aliases to add in the format (alias1 alias2 ...) (githubUsername1 githubUsername2 ...). You probably want to add yourself here so you can later do something like "git push myself"
extraGitAliases=("devoted" "max")
extraGithubNames=("DevotedMC" "Maxopoly")

#Do you want PaperMC to be installed? Set only to false if you already have it
installPaper='true'



#Don't touch anything beyond this point unless you REALLY know what you're doing -------------------------------------------------------------
pathSep="/"
targetFolder=$currentDir$pathSep$folderName
orgName="CivClassic"
sshURLPrefix="git@github.com:"
httpURLPrefix="https://github.com/"
webPathSep="/"
gitSuffix=".git"
extraGitAliasAmount=${#extraGitAliases[@]}

civPlugins='style-guide CombatTagPlus CivModCore RealisticBiomes HiddenOre NameLayer Citadel CivChat2 FactoryMod JukeAlert Bastion RailSwitch BanStick Brewery WorldBorder RandomSpawn ExilePearl CivDuties CivSpy Finale ItemExchange EssenceGlue NameColors KiraBukkitGateway SimpleAdminHacks'

mkdir -p $targetFolder
cd $targetFolder

#Install Paper 1.16.4
if $installPaper ; then
	git init paper
	cd paper
	git config core.autocrlf false
	git remote add origin https://github.com/PaperMC/Paper.git
	git fetch --all
	git reset --hard aaff430b6e1f71c875532df01b099228f7de40b7
	./paper jar
fi

for civPlugin in $civPlugins ; do
	echo "Setting up dev environment for plugin $civPlugin"
	currPluginPath=$targetFolder$pathSep$civPlugin
	mkdir -p $currPluginPath
	cd $currPluginPath
	git init
	if $useSSH ; then
		pluginURL=$sshURLPrefix$orgName$webPathSep$civPlugin$gitSuffix
	else
		pluginURL=$httpURLPrefix$orgName$webPathSep$civPlugin$gitSuffix
	fi
	git remote add civclassic $pluginURL
	git fetch civclassic
	git merge civclassic/master
	for (( i=0; i<$extraGitAliasAmount; i++ )); do
		currUserName="${extraGithubNames[$i]}"
		currAlias="${extraGitAliases[$i]}"
	if $useSSH ; then
		remoteURL=$sshURLPrefix$currUserName$webPathSep$civPlugin$gitSuffix
	else
		remoteURL=$httpURLPrefix$currUserName$webPathSep$civPlugin$gitSuffix
	fi
	git remote add $currAlias $remoteURL
	git fetch $currAlias
	mvn clean package install
	done
done

