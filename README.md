Checkstyle sheet for DevotedMC's plugin development.



All plugins actively maintained by DevotedMC are formatted according to these checkstyle rules and contributors are highly encouraged to follow them as well


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
          <configLocation>fix.me.to.buildserver</configLocation>
        </configuration>
      </plugin>
    </plugins>
  </reporting>
  ...
</project>

```
