SCRIPTPATH="$( cd -- "$(dirname $(dirname "$0"))" >/dev/null 2>&1 ; pwd -P )"
docker-compose -f "$SCRIPTPATH/docker-compose-no-volumes.yml" down