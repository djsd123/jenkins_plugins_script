#!/usr/bin/env bash

# Source plugin Array
. ./plugins.sh

# Jenkins Host
HOST=localhost:8080

JENKINS_URL=pluginManager/installNecessaryPlugins

# API User
API_USERNAME=$(whoami)

# Get user api Token
API_TOKEN=$(curl http://localhost:8080/user/"${API_USERNAME}"/configure?pretty --user timmy:timmy |grep -o 'value\=\"[a-z0-9]\{32\}\"' | tr -d '"'| sed 's/\<value\>//' | tr -d '=')

# Get CSRF Token Crumb Header
CSRF_CRUMB_HEADER=$(curl -XGET 'http://'"${API_USERNAME}"':'"${API_TOKEN}"'@localhost:8080/crumbIssuer/api/xml?xpath=concat(//crumbRequestField,":",//crumb)')

#Install plugins
for i in "${PLUGINS[@]}"; do
  curl -XPOST 'http://'"${API_USERNAME}"':'"${API_TOKEN}"'@'"${HOST}"'/'"${JENKINS_URL}"'' -d '<jenkins><install plugin="'"${i}"'" /></jenkins>' -H ''"${CSRF_CRUMB_HEADER}"''
done
