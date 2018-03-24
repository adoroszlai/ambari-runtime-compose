# Ambari Docker Compose Runtime

Sample Docker Compose files for running Ambari with PostgreSQL or MySQL, and a local repo (optional)

## Usage

 1. Define `AMBARI_BUILD` (eg. `2.6.1`) and `AMBARI_FLAVOR` (eg. `centos7`) variables (look for available [ambari-server](https://hub.docker.com/r/adoroszlai/ambari-server/tags/) and [ambari-agent](https://hub.docker.com/r/adoroszlai/ambari-agent/tags/) images on Docker Hub)
 2. Create `password.dat` with the password for the `ambari` DB user
 3. Run Ambari:
    ```
    docker-compose -p ambari -f server.yaml -f agent.yaml -f db/postgres.yaml up -d
    ```
 4. Scale the cluster by adding new `agent` nodes:
    ```
    docker-compose -f ... scale agent=2
    ```

## Notes

 * Define the set of compose files to be used in the `COMPOSE_FILE` environment variable to avoid having to type all of them for each command.
   ```
   COMPOSE_FILE=server.yaml:agent.yaml:db/postgres.yaml:repo.yaml
   ```
 * Most Ambari settings are defined in `*.env` files.  These are converted to the real config files by [envtoconf](https://github.com/elek/envtoconf) invoked by the [flokkr/launcher](https://github.com/flokkr/launcher).  This allows mixing in settings from the compose files or other sources.
 * For using Ambari with MySQL, download [MySQL Connector/J](https://dev.mysql.com/downloads/connector/j/), and define the jar's location on the host in the `MYSQL_JDBC_DRIVER` variable.  The file will be mounted in Ambari Server's container.
 * If some stack is available locally, point `REPO_DIR` to it and add `repo.yaml` the list of compose files.  Set base URLs in Ambari to `http://repo/...`
