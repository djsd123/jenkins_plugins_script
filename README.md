### jenkins_plugins_script
A script to install Jenkins plugins _WITHOUT_ having to specify dependencies

_Only tested with Jenkins 2.x_

The script installs plugins defined in the `plugins.sh`.  Format <PLUGIN_NAME@PLUGIN_VERSION>. Plugins defined but already installed will be checked that they match the specified version and ignored.
You could also define a plugin like this `nodelabelparameter@latest` to ensure your plugin stays up to date.

I'm making some assumptions here. Such as:

* You're using a unix derived OS or bash like shell
* An administrative jenkins user account and the local user you're running the script with 
have the same name.

You'll have to modify the script to work with your jenkins setup

#### Getting an api user token for another

By default, in newer versions of Jenkins you will be unable to view another
users token. To get past this, temporarily set the following as an argument under
JAVA_ARGS in the init script and restart the Jenkins service:
```Bash
-Djenkins.security.ApiTokenProperty.showTokenToAdmins=true
```
Ref: https://wiki.jenkins-ci.org/display/JENKINS/Features+controlled+by+system+properties
