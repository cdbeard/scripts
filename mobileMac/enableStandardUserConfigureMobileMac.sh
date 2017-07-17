#!/bin/bash
#
# V3 - paramterise to allow granularity

usage="Usage: $0 [ -t -p -n ]\n  -t: enable standard user to configure Time Machine SysPrefs pane\n  -p: enable standard user to configure Printers & Scanners pane\n  -n: enable standard user to configure Network pane\n"

# Check root
if [[ `id -u` -ne 0 ]]; then
  echo "This script must be run as root."
  exit 1
fi

# Determine what is to be done
if [[ "$#" -eq 0 ]]; then
  echo "No options provided."
  printf "${usage}"
  exit 1
fi

while [[ "$#" -gt 0 ]]; do 
  case "$1" in
    --timemachine|-t)
      timemachine=true;;
    --printing|-p)
      printing=true;;
    --network|-n)
      network=true;;
    *)
      printf "${usage}"  
      exit 1;
  esac
  shift
done

if [[ "${timemachine}" == true ]]; then
  printf "Unlocking Time Machine pane...\n"

  security authorizationdb read system.preferences > /tmp/system.preferences.plist
  defaults write /tmp/system.preferences.plist rule -string allow
  security authorizationdb write system.preferences < /tmp/system.preferences.plist
  
  security authorizationdb read system.preferences.timemachine > /tmp/system.preferences.timemachine.plist
  defaults write /tmp/system.preferences.timemachine.plist rule -string allow
  security authorizationdb write system.preferences.timemachine < /tmp/system.preferences.timemachine.plist
fi

if [[ "${printing}" == true ]]; then
  printf "Unlocking Printers & Scanners pane...\n"
  
  security authorizationdb read system.preferences.printing > /tmp/system.preferences.printing.plist
  defaults write /tmp/system.preferences.printing.plist rule -string allow
  security authorizationdb write system.preferences.printing < /tmp/system.preferences.printing.plist
fi  
  
if [[ "${network}" == true ]]; then
  printf "Unlocking Network pane...\n"
  
  security authorizationdb read system.preferences.network > /tmp/system.preferences.network.plist
  defaults write /tmp/system.preferences.network.plist rule -string allow
  security authorizationdb write system.preferences.network < /tmp/system.preferences.network.plist

  security authorizationdb read system.services.systemconfiguration.network > /tmp/system.services.systemconfiguration.network.plist
  defaults write /tmp/system.services.systemconfiguration.network.plist rule -string allow
  security authorizationdb write system.services.systemconfiguration.network < /tmp/system.services.systemconfiguration.network.plist
fi
