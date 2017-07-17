#!/bin/bash
#
# V1 - enable all features

# Check root
if [[ `id -u` -ne 0 ]]; then
  echo "This script must be run as root."
  exit 1
fi

security authorizationdb write system.preferences.printing allow

security authorizationdb write system.preferences.network allow
security authorizationdb write system.services.systemconfiguration.network allow

security authorizationdb write system.preferences allow
security authorizationdb write system.preferences.timemachine allow
