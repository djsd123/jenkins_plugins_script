### jenkins_plugins_script
A script to install Jenkins plugins _WITHOUT_ having to specify dependencies

_Only tested with Jenkins 2.x_

The script installs plugins defined in the `plugins.sh`.  Format _PLUGIN_NAME@PLUGIN_VERSION_. Plugins defined but already installed will be checked that they match the specified version and ignored.
You could also define a plugin like this `nodelabelparameter@latest` to ensure your plugin stays up to date.

I'm making some assumptions here. Such as:

* You're using a unix derived OS or bash like shell
* An administrative jenkins user account and the local user you're running the script with have the same name.
* The administrative jenkins user account's username and password are the same string. (Please secure when it comes to real world use)

You'll have to modify the script to work with your jenkins setup

### Usage
Update `plugins.sh` with the plugins you want installed.
```
PLUGINS=(
  scm-sync-configuration@0.0.10
  nodelabelparameter@latest
  golang@1.1
  pyenv@0.0.7
)
```
Run `jenkins_api_plugin_install.sh`
```
vagrant@trusty1:~$ ./jenkins_api_plugin_install.sh 
Dec 15, 2016 4:24:10 PM hudson.model.UpdateCenter$UpdateCenterConfiguration download
INFO: Downloading pyenv plugin
Dec 15, 2016 4:24:24 PM hudson.PluginManager dynamicLoad
INFO: Plugin pyenv:0.0.7 dynamically installed
Dec 15, 2016 4:24:24 PM hudson.model.UpdateCenter$DownloadJob run
INFO: Installation successful: pyenv plugin
```
#### Getting an api user token for another

By default, in newer versions of Jenkins you will be unable to view another
users token. To get past this, temporarily set the following as an argument under
JAVA_ARGS in the init script and restart the Jenkins service:
```Bash
-Djenkins.security.ApiTokenProperty.showTokenToAdmins=true
```
Ref: https://wiki.jenkins-ci.org/display/JENKINS/Features+controlled+by+system+properties
