#!/bin/bash
#
# V7 Rewrite to meet JSS script requirements.

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

usage="Usage: $0 <dummy> <dummy> <dummy> <[ (-|+)<feature1> | (-|+)<feature2> | etc ]\n\
  <feature>:   t(imemachine) | p(rinting) | n(etwork)\n\
  -<feature>:  allow standard user to configure OS feature\n\
  +<feature>:  set feature restrictions to default\n\
This script is intended to be run from a JSS which will automatically populate the first three parameters.\n"

if [[ `id -u` -ne 0 ]]; then
  printf "ERROR: This script must be run as root.\n"
  exit 1
fi

# Determine what is to be done
if [[ "$#" -eq 0 ]]; then
  printf "ERROR: No options provided.\n"
  printf "${usage}"
  exit 1
fi

# Remove first 3 parameters. JSS will populate these when it runs script.
printf "Mount point: $1\n"
shift
printf "Computer name: $1\n"
shift
printf "Username: $1\n"
shift

while [[ "$#" -gt 0 ]]; do
  case "$1" in
    -timemachine|-t)
      tmaction=allow
      tmcount=$[$tmcount+1];;
    +timemachine|+t)
      tmaction=default
      tmcount=$[$tmcount+1];;
    -printing|-p)
      praction=allow
      prcount=$[$prcount+1];;
    +printing|+p)
      praction=default
      prcount=$[$prcount+1];;
    -network|-n)
      neaction=allow
      necount=$[$necount+1];;
    +network|+n)
      neaction=default
      necount=$[$necount+1];;
    *)
      printf "${usage}"
      exit 1;
  esac
  shift
done

if [[ "${tmcount}" -gt 1 ]] || [[ "${prcount}" -gt 1 ]] || [[ "${necount}" -gt 1 ]]; then
  printf "ERROR: Conflicting options specified.\n"
  printf "${usage}"
  exit 1
fi

if [[ "${tmcount}" -eq 1 ]]; then
  printf "Trying to set Time Machine pane access to ${tmaction}:\n"
  controlAuthRight system.preferences "${tmaction}"
  controlAuthRight system.preferences.timemachine "${tmaction}"
fi

if [[ "${prcount}" -eq 1 ]]; then
  printf "Trying to set Printers & Scanners pane access to ${praction}:\n"
  controlAuthRight system.preferences.printing "${praction}"
fi

if [[ "${necount}" -eq 1 ]]; then
  printf "Trying to set Network pane access to ${neaction}:\n"
  controlAuthRight system.preferences.network "${neaction}"
  controlAuthRight system.services.systemconfiguration.network "${neaction}"
fi
