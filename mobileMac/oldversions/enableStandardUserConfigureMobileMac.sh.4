#!/bin/bash
#
# V4 - create functions to allow/default the settings. 

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
  printf "Unlocking Time Machine pane:\n"
  controlAuthRight system.preferences allow
  controlAuthRight system.preferences.timemachine allow
fi

if [[ "${printing}" == true ]]; then
  printf "Unlocking Printers & Scanners pane:\n"
  controlAuthRight system.preferences.printing allow 
fi  
  
if [[ "${network}" == true ]]; then
  printf "Unlocking Network pane:\n"
  controlAuthRight system.preferences.network allow
  controlAuthRight system.services.systemconfiguration.network allow
fi
