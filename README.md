# CivClassic style guide

General style guide for CivClassics plugin development.

All plugins actively maintained by CivClassic follow these rules in their layout and are formatted according to them. Contributors are expected to follow them as well.

## File layout

An example repository to illustrate this layout with recommended defaults for most files is provided [here](https://github.com/CivClassic/CivTemplate)

### Top level directory

Contains only the following:






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
          <configLocation>https://raw.githubusercontent.com/DevotedMC/style-guide/master/src/main/resources/devoted_checks.xml</configLocation>
        </configuration>
      </plugin>
    </plugins>
  </reporting>
  ...
</project>

```


The config location in this pom section refers to Devoteds Stylesheet, which is hosted [here](https://build.devotedmc.com/job/Style-guide-master/lastSuccessfulBuild/artifact/src/main/resources/devoted_checks.xml). If needed you could replace it with whatever you want, the configLocation tag accepts both local paths and URL.


The .editorconfig should be copied over and placed in the root directory of the project like it is done for this project.
