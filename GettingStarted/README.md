# Getting Started

These instructions, while covering generally expected environments, will not cover all environments, nor are they guraunteed to work; they're provided "as is" without warranty of any kind, express or implied; that you follow these instructions at your own risk.

## Setting up your development environment

1. Install Oracle Java 11: `https://www.oracle.com/java/technologies/javase-jdk11-downloads.html` 

	* or OpenJDK 11: `https://adoptopenjdk.net/`

	* *other Java providers are available, but it's recommended to avoid them unless you know what you are doing.*

2. Install git: `https://git-scm.com/downloads`

3. Install Maven: `https://maven.apache.org/download.cgi`

	* macOS: `brew install maven`

	* Linux: `sudo apt install maven`

	* Windows: follow these instructions `https://mkyong.com/maven/how-to-install-maven-in-windows/` (tedious)

4. Install a Java Development Environment

    * Eclipse is good: `https://www.eclipse.org/downloads/packages/release/2020-12/r/eclipse-ide-java-developers`

    * IntelliJ is good: `https://www.jetbrains.com/idea/download/`

    * Visual Studio Code is decent: `https://code.visualstudio.com/`

    * Hardcore? Notepad++ is popular: `https://notepad-plus-plus.org/download/`

    * TextPad is a good hardcore for Windows: `http://www.textpad.com/download/`

    * Badass? Vim: `http://www.vim.org/download.php` or Emacs: `http://www.gnu.org/software/emacs/#Obtaining`

5. Install PaperMC:

    1. Clone PaperMC `git clone https://github.com/PaperMC/Paper && cd Paper`

    2. Revert it to the latest 1.16.1 commit `git reset --hard 627f4b8561115d40d6a39587d1ad94b0104f7e14`

    3. Build Paper to install it in your local Maven cache and make it available as dependency `./paper jar`


At this point you should be able to import plugins into your IDE and compile them by invoking `mvn` in their respective folder. Further instructions are only needed if you also desire a test server to test your changes on. Alternatively to this manual setup, see also our [Ansible deployment environment](https://github.com/civclassic/ansiblesetup) which automates setting up a full copy of Civclassic production.


6. Install MariaDB: `https://mariadb.org/download/`

	* If you're on macOS or Linux, you may find it easier to install via package managers, such as:

		* macOS: `brew install mariadb`

		* Linux: `sudo apt install mariadb-server`

	* Post installation setup differs from platform to platform

		* If you're on Windows, you're able to set the root password as part of the installation process

		* Some platforms and some versions support the use of `mysql_secure_installation`, while others require more elaborate terminal work. Here are some guides:

			* `https://mariadb.com/kb/en/mysql_secure_installation/`

			* `https://www.digitalocean.com/community/tutorials/how-to-reset-your-mysql-or-mariadb-root-password`

	* If you get the message: "Specified key was too long; max key length is 767 bytes"

		* Change your database encoding to latin1 (undesireable but apparently works)

		* Alternatively, upgrade to at least MariaDB 10.2 (this may require an OS update for your server hosting platform)

---

## Post Install

1. Download plugins from: `https://build.devotedmc.com/job/Civclassic/`

    * If a plugin or version cannot be found, you can compile them directly from `https://github.com/CivClassic`

        * Open the cloned plugin in a terminal and run `mvn clean package`

        * This will compile the plugin into a jar in `<project root>/target/`

        * If build fails because civclassic-parent POM cannot be located:

            * Clone the CivClassic style-guide: `https://github.com/CivClassic/style-guide`

            * Open the cloned style-guide project folder in a terminal

            * Run `mvn install`

2. Stop the server if it's already running.

    * You can also hot load the plugins if you're using PlugMan (`https://dev.bukkit.org/projects/plugman`) or any other plugin manager, though these can have complications and restarting the server may be necessary anyway.

3. Drop the built jars into the server's `/plugins` folder and start the minecraft server.

4. Some plugins like CivModCore, NameLayer, and Citadel require database connections to fully function.

    * [Re]start the server or [re]load the plugin to spawn a default config.

    * Uncomment out the database section to look something like:

        ```yaml
        database:
          ==: vg.civcraft.mc.civmodcore.dao.ManagedDatasource
          plugin: <plugin name>
          username: <your username>
          password: <your password>
          database: <your database>
          host: localhost
          port: 3306
          poolSize: 5
          connectionTimeout: 10000
          idleTimeout: 600000
          maxLifetime: 7200000
        ```

    * Change the plugin, username, password, and database values to reflect your needs.

    * Restart the server or reload the plugin.

---

## Plugins

Note that NameLayer and Citadel are currently in constant flux. The following is a stable plugin set:

* CivModCore 1.8.0

  (`https://build.devotedmc.com/job/Civclassic/job/CivModCore/job/master/`)

* NameLayer 2.14.0

  (`https://build.devotedmc.com/job/Civclassic/job/NameLayer/job/master/`)

* Citadel 4.1.0

  (`https://build.devotedmc.com/job/Civclassic/job/Citadel/job/master/`)
  
---

## Editor Specifics

### Intellij

Make sure to use the proper formatting settings for projects by selecting `Project`.
* Go to: `File -> Settings -> Code Style -> Java -> Scheme`
* Select: `Project` as Formatter Setting

![intellij settings](img/intellij_project_formatter_style.png)
