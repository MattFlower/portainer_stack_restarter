When this docker image runs, it will restart a docker compose stack in a portainer instance.

Use the following environment variables to control it:

* PORTAINER_USERNAME Name used to log into portainer.  This username needs access to execute api calls.
* PORTAINER_PASSWORD Password used to log into portainer
* APP_TO_RESTART The name of the stack to restart
* HOST_AND_PORT Host and port of the portainer server


