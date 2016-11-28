##Devoted style guide

Checkstyle sheet for DevotedMC's plugin development.




All plugins actively maintained by DevotedMC are formatted according to these checkstyle rules and contributors are expected to follow them as well.

# How to setup your IDE

Ideally all of the formatting required will be done by your IDE, you shouldnt have to worry about white spaces and formatting while coding. The following instructions will get you as close as possible to that and we highly recommend following through with them before working on plugin changes that are meant to be merged upstream.

Currently we only 'officially' support Eclipse here, because it's what most of our developers use. You are free to use whatever IDE you want, but you'll have to figure out on your own how to setup Checkstyle, Editorconfig etc. in those. If you do figure it out for other IDEs, adding your knowledge to this README would be very welcome.


### Eclipse

First of all we need to add two plugins to Eclipse:

In Eclipse's menu bar at the top click "Help", then "Eclipse Marketplace..." and you should see the Marketplace window pop up:

![alt tag](http://i.imgur.com/uHfZVo7.png)

If the market place window appears to be frozen at any point, just give it a bit of time. The GUI tends to freeze while loading content, but usually it catches up after a bit.

On the upper left side of the window, you should see a search bar, enter "Checkstyle" and hit Enter. You should now see the "Checkstyle Plugin-in 7.2.0" (or a higher version). Click install and follow the instructions to install the plugin.

![alt tag](http://i.imgur.com/kC2KybY.png)


Next we need a plugin to handle editor configs, so search "editorconfig" and install the plugin "editorconfig-eclipse 0.2.2" (or higher version) with the same process as above.


The editor config will work on it's own and detect the .editorconfig file in each repo, but unfortunately the checkstyle plugin won't use the style sheet specified in the pom.xml on it's own, so we need to manually set it in your eclipse settings.


Start by cloning this repo ``` git clone git@github.com:DevotedMC/style-guide.git```

In Eclipse at the top open the "Window" dropdown menu. Click "Preferences" and you should see this window opening up:

![alt tag](http://i.imgur.com/dEDmsBc.png)

Click "Checkstyle" in the tree view on the left and then on the right of the checkstyle tab the "New..." button. 

![alt tag](http://i.imgur.com/rGfEyQh.png)

You should now see another dialog like this open up:

![alt tag](http://i.imgur.com/c0Naa5C.png)

##TODO from here on

Set type to "External Configuration File", enter a name (for example "Devoted") and for the location browse to the directory you cloned the style-guide repo to earlier and then select the file src/main/resources/devoted_checks.xml. The description is optional and the other settings are fine in their default state, press "OK" once you are done.

Sidenote: Checkstyle does offer the option "Remote configuration", which seems like a better solution here, because it'll automatically update the configuration and doesn't require cloning the style-guide repo. The issue with that option is that the JVM doesn't natively accept HTTPS certs issued by LetsEncrypt like the one [our Jenkins](https://build.devotedmc.com/) is using, so if you use the same URL as in the pom.xml, it wont work. There are multiple ways around this, you can edit the keystore of your JDK to manually add LetsEncrypt as certificate authority or you could use a direct link

# How to use in your plugin

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

