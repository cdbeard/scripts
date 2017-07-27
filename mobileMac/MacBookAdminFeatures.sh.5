#!/bin/bash
#
# V5 Rewrite to enable/disable all necessary MacBook rights.

function controlAuthRight {
  domain=$1
  action=$2
  plistPath="/tmp/${domain}.plist"


  if [[ "${action}" != "allow" && "${action}" != "default" ]]; then
    printf "controlSystemPreference function called with invalid 'action' argument (valid: allow, default).\n"
    exit 1
  fi

  printf "Setting security domain ${domain} to ${action}...\n"
  security authorizationdb read ${domain} > ${plistPath}
  defaults write ${plistPath} rule -string ${action}
  security authorizationdb write ${domain} < ${plistPath}
}

usage="Usage: $0 [ enable | disable ]\n  enable: enable standard user to configure necessary mobile macOS features\n  disable: set restrictions to default\n"

if [[ `id -u` -ne 0 ]]; then
  echo "This script must be run as root."
  exit 1
fi

if [[ "$#" -ne 1 ]]; then
  printf "${usage}"
  exit 1
fi

case "$1" in
  enable)
    printf "Unlocking Time Machine pane:\n"
    controlAuthRight system.preferences allow
    controlAuthRight system.preferences.timemachine allow

    printf "Unlocking Printers & Scanners pane:\n"
    controlAuthRight system.preferences.printing allow 
  
    printf "Unlocking Network pane:\n"
    controlAuthRight system.preferences.network allow
    controlAuthRight system.services.systemconfiguration.network allow
    ;;
  disable)
    printf "Locking Time Machine pane:\n"
    controlAuthRight system.preferences default
    controlAuthRight system.preferences.timemachine default

    printf "Locking Printers & Scanners pane:\n"
    controlAuthRight system.preferences.printing default 
  
    printf "Locking Network pane:\n"
    controlAuthRight system.preferences.network default
    controlAuthRight system.services.systemconfiguration.network default
    ;;
  *)
    printf "${usage}"
    exit 1;
esac
