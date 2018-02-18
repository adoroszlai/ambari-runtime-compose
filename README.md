Environment for running Ambari built locally.  Inspired by [lpuskas/ambari-dev-env](https://github.com/lpuskas/ambari-dev-env).

 * Ambari Server image based on [flokkr/docker-baseimage](https://github.com/flokkr/docker-baseimage)
 * Ambari Agent image based on [centos:6](https://hub.docker.com/_/centos/)
 * Docker Compose files for running Ambari with PostgreSQL and a local repo (optional)

## Usage

 1. Make `AMBARI_PROJECT` variable point to local Ambari source location (define as shell variable or in `.env`)
 2. Define `AMBARI_OUTPUT` variable with desired output (logs) location (also as shell variable or in `.env`)
 3. Create `password.dat` with the password for the `ambari` DB user
 4. Build the Docker images: `make build`
 5. Build (parts of) Ambari:
    ```
    mvn -am -pl ambari-admin,ambari-agent,ambari-server,ambari-web -Del.log=WARN -DskipTests -Dcheckstyle.skip -Drat.skip -Dfindbugs.skip clean package
    ```
 6. Run Ambari, eg.: `docker-compose -f ambari-server.yaml -f postgres.yaml -f ambari-agent.yaml up`

## Notes

 * Most Ambari settings are defined in `*.env` files.  These are converted to the real config files by [envtoconf](https://github.com/elek/envtoconf) invoked by the [flokkr/launcher](https://github.com/flokkr/launcher).  This allows mixing in settings from the compose files or other sources.
