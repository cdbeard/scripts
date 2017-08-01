#!/bin/bash
#
# Revert printing, network and time machine access to default

# Check root
if [[ `id -u` -ne 0 ]]; then
  echo "This script must be run as root."
  exit 1
fi

printf "Locking Time Machine pane...\n"

security authorizationdb read system.preferences > /tmp/system.preferences.plist
defaults write /tmp/system.preferences.plist rule -string default
security authorizationdb write system.preferences < /tmp/system.preferences.plist
  
security authorizationdb read system.preferences.timemachine > /tmp/system.preferences.timemachine.plist
defaults write /tmp/system.preferences.timemachine.plist rule -string default
security authorizationdb write system.preferences.timemachine < /tmp/system.preferences.timemachine.plist

printf "Locking Printers & Scanners pane...\n"
  
security authorizationdb read system.preferences.printing > /tmp/system.preferences.printing.plist
defaults write /tmp/system.preferences.printing.plist rule -string default
security authorizationdb write system.preferences.printing < /tmp/system.preferences.printing.plist
  
printf "Locking Network pane...\n"
  
security authorizationdb read system.preferences.network > /tmp/system.preferences.network.plist
defaults write /tmp/system.preferences.network.plist rule -string default
security authorizationdb write system.preferences.network < /tmp/system.preferences.network.plist

security authorizationdb read system.services.systemconfiguration.network > /tmp/system.services.systemconfiguration.network.plist
defaults write /tmp/system.services.systemconfiguration.network.plist rule -string default
security authorizationdb write system.services.systemconfiguration.network < /tmp/system.services.systemconfiguration.network.plist
