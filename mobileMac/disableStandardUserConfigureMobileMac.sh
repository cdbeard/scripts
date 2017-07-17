#!/bin/bash
#
# Revert using security...default 

# Check root
if [[ `id -u` -ne 0 ]]; then
  echo "This script must be run as root."
  exit 1
fi

printf "Locking printing for standard users...\n"
security authorizationdb write system.preferences.printing default

printf "Locking networking for standard users...\n"
security authorizationdb write system.preferences.network default
security authorizationdb write system.services.systemconfiguration.network default

printf "Locking Time Machine for standard users...\n"
security authorizationdb write system.preferences default
security authorizationdb write system.preferences.timemachine default
