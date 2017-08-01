# A selection of scripts

## macBookAdminRights.sh

Bash script intended for use with mobile Macs allowing standard users to configure Network, Printers and Time Machine panes in System Preferences. These are three features we were previously providing MacBook users with admin accounts in order to manage. It uses the 'security' command to edit the relevant settings in the authorisation database. For an overview of the rights available see https://www.dssw.co.uk/reference/authorization-rights/ as this could easily be expanded to cover other features.

```
Usage: ./macBookAdminFeatures.sh <dummy> <dummy> <dummy> [ <feature1> | <feature2> | <feature3> | etc ]
  <feature>:   -t|--timemachine    allow standard user to configure Time Machine
  <feature>:   +t|++timemachine    set Time Machine access to default
  <feature>:   -n|--network        allow standard user to configure Network
  <feature>:   +n|++network        set Network access to default
  <feature>:   -p|--printing       allow standard user to configure Printers & Scanners
  <feature>:   +p|++printing       set Printer access to default
This script is intended to be run from a [jamf Pro] JSS which will automatically populate the first three parameters.
```
