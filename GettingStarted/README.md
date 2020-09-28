# Getting Started

## Setting up your development environment

1. Install git: https://git-scm.com/downloads

2. Install Maven: https://maven.apache.org/download.cgi

3. Install a Java Development Environment

    * Eclipse is good: https://www.eclipse.org/downloads/packages/eclipse-ide-java-developers/lunasr2

    * IntelliJ is good: https://www.jetbrains.com/idea/download/

    * Hardcore? Notepad++ is popular: https://notepad-plus-plus.org/download/

    * Textpad is a good hardcore for Windows: http://www.textpad.com/download/

    * Badass? Vim: http://www.vim.org/download.php or Emacs: http://www.gnu.org/software/emacs/#Obtaining

4. Download Spigot BuildTools.jar: https://www.spigotmc.org/wiki/buildtools/

    1. Follow instructions on wiki to download the required version of Spigot

    2. Compile Spigot & Craftbukkit from BuildTools.jar:

        java -jar BuildTools.jar --rev 1.16.1 --compile craftbukkit

5. Install spigot & craftbukkit into your maven repository (be sure to match file directory with their respective locations):

    mvn install:install-file -Dfile=./spigot/spigot-1.16.1.jar -DgroupId=org.spigotmc -DartifactId=spigot -Dversion=1.16.1 -Dpackaging=jar -DpomFile=./spigot/spigot-pom.xml

    mvn install:install-file -Dfile=./spigot/craftbukkit-1.16.1.jar -DgroupId=org.bukkit -DartifactId=craftbukkit -Dversion=1.16.1 -Dpackaging=jar -DpomFile=./spigot/craftbukkit-pom.xml

--------------------

## Post set-up in either case

1. Check out your favorite CivClassic mod and start hacking: https://github.com/CivClassic

2. Most of them are "good" mods and after cloning them locally you can issue: 

    * `mvn clean package "-Dbuild.number=Local"`

    * That builds the mod, and puts the output jar in ./target off the repository root.

    * The build.number stuff just gives a meaningful assignment to the incremental build number in the POM (maven details, go read up on it).

    * If build fails because civclassic-parent POM cannot be located, clone the CivClassic Style-Guide, https://github.com/CivClassic/style-guide, and install the artifact manually:

        mvn install:install-file -Dfile=./style-guide/pom.xml -DgroupId=com.github.civclassic -DartifactId=civclassic-parent -Dversion=1.0.0 -Dpackaging=pom

3. Drop the built jars into the vm's `/minecraft/plugins` folder and restart the minecraft server.

-----------------

## Devoted Clone TODO

Note that currently, Namelayer and Citadel are in constant flux. The following is a stable plugin set:

    CivModCore 1.8.0

    NameLayer 2.14.0

    Citadel 4.1.0

If you want to contribute to these plugins, you're going to need to go to most recent version on the plugin's master branch.

### CivModCore Setup (1.8.0)

1. Grab the latest CivModCore jar from the Civcraft build server, or build locally

2. Put the jar into `/minecraft/plugins`

3. Continue.


### Namelayer Setup (2.14.0)

1. Grab the latest jar from Civcraft build server, or build locally (links, can we also get Github releases for devotedbuilds?)

2. Put the jar into `/minecraft/plugins`

3. Start the server, observe the errors

4. Shut down the server.

5. Open `/minecraft/plugins/Namelayer/config.yml` -- note the need for username and password

6. Install mysql -- `sudo apt-get install mariadb-server`

    * It's up to you if you want to set a root password; if you don't you'll be asked a bunch of times.

7. Log in to mysql -- `sudo mysql` 

8. Create namelayer credentials -- `CREATE USER mc_namelayer IDENTIFIED BY 'minecraft';` -- clearly not high security here.

9. Create a database for this user -- `CREATE DATABASE IF NOT EXISTS namelayer`

10. Give permission to use the database to your user -- `GRANT ALL ON namelayer.* TO mc_namelayer`

11. `exit` the mysql shell.

12. Test your user and database -- `mysql namelayer -umc_namelayer -p` entering in password `minecraft` -- if this gives no errors, you're ready to go.

13. Go back to `/minecraft/plugins/Namelayer/config.yml` and edit it to look like this (afterwards change the config files CivModCore and Citadel using same credentials):

    ```
    sql:  
        hostname: localhost  
        port: 3306  
        dbname: namelayer  
        username: 'mc_namelayer'  
        password: 'minecraft'  
    groups:  
        enable: true
    ```

14. Restart the spigot server.

15. Stop and restart spigot one last time.

### Citadel Setup (4.1.0)

1. If Namelayer is installed, just grab the latest jar from Civcraft build server, or build locally

2. Put the jar into `/minecraft/plugins`

3. Start the server

### Known Issues

* If you get the message, `Specified key was too long; max key length is 767 bytes`
    
    * change you database encoding to latin1

    * alternatively, upgrade to at least MariaDB 10.2 (this may require an OS update for your server hosting platform)