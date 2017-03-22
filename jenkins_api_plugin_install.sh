# Source plugin Array
. ./plugins.sh

# Jenkins Host
HOST=localhost:8080

JENKINS_URL=pluginManager/installNecessaryPlugins

# API User
API_USERNAME=$(whoami)

#API user's password
#API_PASSWORD=$API_USERNAME

#API user's password (interactive)
echo -n "password: "
read -s PASSWORD
API_PASSWORD=$PASSWORD

usage() {
cat <<EOH

You must supply the password for your user account in Jenkins.

EOH

}

if [[ -z "$API_PASSWORD" ]]; then
  usage
  exit 1
fi

# Get user's api Token
API_TOKEN=$(curl http://localhost:8080/user/"${API_USERNAME}"/configure?pretty --user "${API_USERNAME}":"${API_PASSWORD}" |grep -o 'value\=\"[a-z0-9]\{32\}\"' | tr -d '"'| sed 's/\<value\>//' | tr -d '=')

# Get CSRF Token Crumb Header
CSRF_CRUMB_HEADER=$(curl -XGET 'http://'"${API_USERNAME}"':'"${API_TOKEN}"'@localhost:8080/crumbIssuer/api/xml?xpath=concat(//crumbRequestField,":",//crumb)')

#Install plugins
for i in "${PLUGINS[@]}"; do
  curl --fail --silent -XPOST 'http://'"${API_USERNAME}"':'"${API_TOKEN}"'@'"${HOST}"'/'"${JENKINS_URL}"'' -d '<jenkins><install plugin="'"${i}"'" /></jenkins>' -H ''"${CSRF_CRUMB_HEADER}"''
done

if [[ $? -eq 22 ]]; then
  echo "Failed to authenticate.  Possibly a bad password?"
  exit 1
fi

