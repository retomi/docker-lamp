SCRIPTPATH="$( cd -- "$(dirname $(dirname "$0"))" >/dev/null 2>&1 ; pwd -P )"
sh "$SCRIPTPATH/bin/stop.sh"
sh "$SCRIPTPATH/bin/start.sh"