#!/usr/bin/env bash

#Assumes Java, Maven and git are installed. If you haven't done that yet, see https://github.com/CivClassic/style-guide/tree/master/GettingStarted#setting-up-your-development-environment

#Change this as needed

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

#Don't touch this
pathSep="/"
targetFolder=$currentDir$pathSep$folderName
orgName="CivClassic"
sshURLPrefix="git@github.com:"
httpURLPrefix="https://github.com/"
webPathSep="/"
gitSuffix=".git"
extraGitAliasAmount=${#extraGitAliases[@]}

civPlugins='CombatTagPlus CivModCore RealisticBiomes HiddenOre NameLayer Citadel CivChat2 FactoryMod JukeAlert Bastion RailSwitch BanStick Brewery RandomSpawn ExilePearl CivDuties CivSpy Finale ItemExchange EssenceGlue NameColors OldEnchanting KiraBukkitGateway SimpleAdminHacks AttrHider'

mkdir -p $targetFolder
cd $targetFolder

#Install Paper 1.16.1
if $installPaper ; then
	git clone https://github.com/PaperMC/Paper
	cd Paper/
	git reset --hard 627f4b8561115d40d6a39587d1ad94b0104f7e14
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

