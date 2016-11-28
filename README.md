##Devoted style guide

Checkstyle sheet for DevotedMC's plugin development.




All plugins actively maintained by DevotedMC are formatted according to these checkstyle rules and contributors are expected to follow them as well.

# How to setup your IDE

Ideally all of the formatting required will be done by your IDE, you shouldnt have to worry about white spaces and formatting while coding. The following instructions will get you as close as possible to that and we highly recommend following through with them before working on plugin changes that are meant to be merged upstream.

Currently we only 'officially' support Eclipse here, because it's what most of our developers use. You are free to use whatever IDE you want, but you'll have to figure out on your own how to setup Checkstyle, Editorconfig etc. in those. If you do figure it out for other IDEs, adding your knowledge to this README would be very welcome.


### Eclipse




# How to use in your plugin

Maven has the option to check for checkstyle violations and report them as part of the build process.


To use this, add the following to your pom.xml:

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

