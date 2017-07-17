#!/bin/bash
#
# V2 - user feedback and try defaults write

# Check root
if [[ `id -u` -ne 0 ]]; then
  echo "This script must be run as root."
  exit 1
fi

printf "Unlocking printing for standard users...\n"
# security authorizationdb write system.preferences.printing allow
security authorizationdb read system.preferences.printing > /tmp/system.preferences.printing.plist
defaults write /tmp/system.preferences.printing.plist rule -string allow
security authorizationdb write system.preferences.printing < /tmp/system.preferences.printing.plist


#printf "Unlocking networking for standard users...\n"
#security authorizationdb write system.preferences.network allow
#security authorizationdb write system.services.systemconfiguration.network allow

#printf "Unlocking Time Machine for standard users...\n"
#security authorizationdb write system.preferences allow
#security authorizationdb write system.preferences.timemachine allow
