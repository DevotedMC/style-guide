#Devoted style guide

Checkstyle sheet for DevotedMC's plugin development.




All plugins actively maintained by DevotedMC are formatted according to these checkstyle rules and contributors are expected to follow them as well.

## How to setup your IDE

Ideally all of the formatting required will be done by your IDE, you shouldnt have to worry about white spaces and formatting while coding. The following instructions will get you as close as possible to that and we highly recommend following through with them before working on plugin changes that are meant to be merged upstream.

Currently we only 'officially' support Eclipse here, because it's what most of our developers use. You are free to use whatever IDE you want, but you'll have to figure out on your own how to setup Checkstyle, Editorconfig etc. in those. If you do figure it out for other IDEs, adding your knowledge to this README would be very welcome.


### Eclipse

First of all we need to add plugins for editorconfig and checkstyle to Eclipse. If you already have either of those installed, simply skip the step where it is installed

In Eclipse's menu bar at the top click "Help", then "Eclipse Marketplace..." and you should see the Marketplace window pop up:

![alt tag](http://i.imgur.com/uHfZVo7.png)

If the market place window appears to be frozen at any point, just give it a bit of time. The GUI tends to freeze while loading content, but usually it catches up after a bit.

On the upper left side of the window, you should see a search bar, enter "Checkstyle" and hit Enter. You should now see the "Checkstyle Plugin-in 7.2.0" (or a higher version). Click install and follow the instructions to install the plugin.

![alt tag](http://i.imgur.com/kC2KybY.png)


Next we need a plugin to handle editor configs, so search "editorconfig" and install the plugin "editorconfig-eclipse 0.2.2" (or higher version) with the same process as above.


The editor config will work on it's own and detect the .editorconfig file in each repo, but unfortunately the checkstyle plugin won't use the style sheet specified in the pom.xml on it's own, so we need to manually set it in your eclipse settings.


In Eclipse at the top open the "Window" dropdown menu. Click "Preferences" and you should see this window opening up:

![alt tag](http://i.imgur.com/dEDmsBc.png)

Click "Checkstyle" in the tree view on the left and then on the right of the checkstyle tab the "New..." button. 

![alt tag](http://i.imgur.com/rGfEyQh.png)

You should now see another dialog like this open up:

![alt tag](http://i.imgur.com/c0Naa5C.png)

##TODO from here on

Set type to "Remote configuration", enter a name (for example "Devoted") and for the location paste ``` https://build.devotedmc.com/job/Style-guide-master/lastSuccessfulBuild/artifact/src/main/resources/devoted_checks.xml ``` in . The description is optional and the other settings are fine in their default state, press "OK" once you are done.

Note: If Eclipse refuses to create a configuration with the error message "sun.security.validator.ValidatorException: PKIX path building failed", your JDK is outdated. Our jenkins uses a certificate issued by [Let's Encrypt](https://letsencrypt.org/), which isn't supported in older java versions. To fix this simply download a [JDK of Java 8u101 or higher] (http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html) and point Eclipse at it.

Your new configuration should now appear in the list in the middle of the window. Click it to highlight it and then click the "Set as Default" button the right. A green tick should now appear behind the configuration like this:


![alt tag](http://i.imgur.com/9HovwSZ.png)


Exit the preferences window by pressing "OK" to save all of that.


Now we have checkstyle set up, but checkstyle on it's own only reports errors, it doesn't fix them. To adress that we have to create an Eclipse Formatter profile.

Rightclick a project in your workspace and click Checkstyle --> Create Formatter-Profile. If you dont have a project in your workspace, just quickly make a new project, this option apparently needs to be based on a project using the checkstyle sheet on which the formatter is based, don't ask me why.

Now open up Window --> Preferences again and this time go to Java (double click to expand tree) --> Code Style --> Formatter.

In the uppper half of the window you should now see a dropdown menu called "Active profile":

![alt tag](http://i.imgur.com/EG1ASwK.png)

Select the profile called "eclipse-cs {project-name}", where {project-name} should be the name of the project you just created a formatter based on.

In the treeview on the left side of the window, you should also see the option "Clean Up" under "Code Style", open it up. Change the active profile here as well to the one you just created, the process is the same as for the previous option.

Last we want to change how Eclipse organizes imports. Eclipse by default has a built in priority order based on which imports are ordered, but we simply want imports to be sorted alphabetically.

Under the same "Code Style" option under which already "Clean Up" and "Formatter" were should also be an option "Organize imports". Click it and you should get a list of packages, eacj specifying a regex based on which imports are sorted. We want to delete all of them so just click each of them to mark it and then click remove to the right of the list. 

Once you have removed all entries exit the preferences window by pressing "OK" to save all of that.

Now that we have created formatting profiles and set those as active, we want them to be applied automatically so we dont have to worry about them. To do so, open up Window --> Preferences --> Java --> Editor --> Save Actions.

Tick "Perform the selected actions on save", then tick all three options below and set the formatting behavior to "Formar edited lines". Your window should now look like this:


![alt tag](http://i.imgur.com/BaZBOsn.png)

Hit ok to save those changes and have Eclipse automatically organize and format your code whenever you save it.


You are now done with the mandatory setup part, the following part of the setup section is optional and simply helps you to improve some of the visuals or deal with minor annoyances. If you dont care about those you are done here.



#### Change background color of checkstyle errors
If you don't like the default color in which Eclipse marks checkstyle errors (yellow by default), you can change it. Go to Window --> Preferences --> General --> Editors --> Text Editors --> Annotations and change the color for "Checkstyle warning". Everything reported by checkstyle will be a "Checkstyle warning" with our style sheet, so dont worry about configuring "Checkstyle info" or "Checkstyle error".



//TODO 



## How projects should be setup to use this
Maven has the option to check for checkstyle violations and report them as part of the build process.


To use this in your plugin/maven project, add the following to your pom.xml:

```

<project>
  ...
  <reporting>
    <plugins>
      <plugin>
        <groupId>org.apache.maven.plugins</groupId>
        <artifactId>maven-checkstyle-plugin</artifactId>
        <version>2.17</version>
        <configuration>
          <configLocation>https://build.devotedmc.com/job/Style-guide-master/lastSuccessfulBuild/artifact/src/main/resources/devoted_checks.xml</configLocation>
        </configuration>
      </plugin>
    </plugins>
  </reporting>
  ...
</project>

```


The config location in this pom section refers to Devoteds Stylesheet, which is hosted [here] (https://build.devotedmc.com/job/Style-guide-master/lastSuccessfulBuild/artifact/src/main/resources/devoted_checks.xml). If needed you could replace it with whatever you want, the configLocation tag accepts both local paths and URL.


The .editorconfig should be copied over and placed in the root directory of the project like it is done for this project.
