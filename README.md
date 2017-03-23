### jenkins_plugins_script
A script to install Jenkins plugins _WITHOUT_ having to specify dependencies

_Only tested with Jenkins 2.x_

The script installs plugins defined in the `plugins.sh`.  Format _PLUGIN_NAME@PLUGIN_VERSION_. Plugins that are defined but already installed will be checked that they match the specified version and actioned accordingly.
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
vagrant@trusty1:~/jenkins_plugins_script$ ./jenkins_api_plugin_install.sh 
password:   % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100 18542  100 18542    0     0   148k      0 --:--:-- --:--:-- --:--:--  149k
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100    46  100    46    0     0   3935      0 --:--:-- --:--:-- --:--:--  4181
```

To allow nicer output on failure, I had to surpress the plugin install output i.e. 
```
Dec 15, 2016 4:24:10 PM hudson.model.UpdateCenter$UpdateCenterConfiguration download
INFO: Downloading pyenv plugin
```

You can revert supressed output by removing the `curl` flags `--fail` & `--silent`.  However, the `0` exit status evaluation has been enough to indicate success in my experience.  Please note that bash does not evaluate http errors very well, so I advise not removing the error handling unless you have something better.
#### Getting an api user token for another

By default, in newer versions of Jenkins you will be unable to view another
users token. To get past this, temporarily set the following as an argument under
JAVA_ARGS in the init script and restart the Jenkins service:
```Bash
-Djenkins.security.ApiTokenProperty.showTokenToAdmins=true
```
Ref: https://wiki.jenkins-ci.org/display/JENKINS/Features+controlled+by+system+properties
