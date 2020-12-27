#!/usr/bin/env bash

#Updates an existing setup generated using the setupDevEnv.sh script to install the latest official versions of all plugins in your local Maven repo

#Change these variables as needed

#Directory we are basing in, defaulting to the current one
currentDir=$(pwd)

#Name of the folder all plugins are in relative to the base folder
folderName='civ'


#Don't touch anything beyond this point unless you REALLY know what you're doing -------------------------------------------------------------
pathSep="/"
targetFolder=$currentDir$pathSep$folderName
orgName="CivClassic"
webPathSep="/"
masterBranch="master"
masterBranchRef="$orgName$webPathSep$masterBranch"

civPlugins='style-guide CombatTagPlus CivModCore RealisticBiomes HiddenOre NameLayer Citadel CivChat2 FactoryMod JukeAlert Bastion RailSwitch BanStick Brewery RandomSpawn ExilePearl CivDuties CivSpy Finale ItemExchange EssenceGlue NameColors OldEnchanting KiraBukkitGateway SimpleAdminHacks AttrHider'

if [ ! -d "$targetFolder" ]; then
	echo "Target folder did not exist"
	exit 0
fi
cd $targetFolder

for civPlugin in $civPlugins ; do
	echo "Updating dev environment for plugin $civPlugin"
	currPluginPath=$targetFolder$pathSep$civPlugin
	if [ ! -d "$currPluginPath" ]; then
		echo "Skipping Plugin $civPlugin"
		echo "Expected it at $currPluginPath but couldn't find it"
		continue
	fi
	cd $currPluginPath
	git stash -a #Stash any eventual local work
	git fetch $orgName
	git checkout $masterBranchRef
	mvn clean package install
	done
done

