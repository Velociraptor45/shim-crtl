#!/bin/bash

#src: https://medium.com/@gchudnov/trapping-signals-in-docker-containers-7a57fdda7d86

set -x

# SIGUSR1-handler
my_handler() {
  echo "Terminating with user defined signal 1"
  sudo systemctl stop pimoroni-fanshim.service
}

# SIGTERM-handler
term_handler() {
  echo "Terminating with termination signal"
  sudo systemctl stop pimoroni-fanshim.service
  exit 143; # 128 + 15 -- SIGTERM
}

# setup handlers
# on callback, kill the last background process, which is `tail -f /dev/null` and execute the specified handler
trap 'kill ${!}; my_handler' SIGUSR1
trap 'kill ${!}; term_handler' SIGTERM

# run application
./install-service.sh --on-threshold $ON_THRESHOLD --off-threshold $OFF_THRESHOLD --delay $DELAY --low-temp $LOW_TEMP --high-temp $HIGH_TEMP

# wait forever
while true
do
  tail -f /dev/null & wait ${!}
done