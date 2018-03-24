# Development

Additional compose files for running Ambari built locally.  Inspired by [lpuskas/ambari-dev-env](https://github.com/lpuskas/ambari-dev-env).

 1. Make `AMBARI_PROJECT` variable point to local Ambari source location (define as shell variable or in `.env`)
 2. Build (parts of) Ambari:
    ```
    mvn -am -pl ambari-agent,ambari-server -Del.log=WARN -Dcheckstyle.skip -Dfindbugs.skip -Dmaven.test.skip -Drat.skip clean process-test-resources
    # compile should be enough but some copy-resources executions are bound to the wrong lifecycle phase
    ```
 3. Generate classpath of dependencies:
    ```
    docker-compose -f mvn.yaml run --rm mvn
    ```
 4. Use both base and dev compose files:
    ```
    docker-compose -p ambari_dev -f ../server.yaml -f ../agent.yaml -f ../db/postgres.yaml -f server.yaml -f agent.yaml up -d
    ```

Note that currently not all source files/directories are mounted in the containers, so some edits may not be reflected at runtime.
