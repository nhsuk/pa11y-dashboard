# Dockerized pa11y-dashboard

A Docker container that runs [pa11y-dashboard](https://github.com/pa11y/dashboard).

## Running in Development

Build and run with `./scripts/start`. When running the dashboard will be
available at `http://localhost:3333`.
In order to run in read/write mode run `READONLY=false ./scripts/start`.

## Running on a server

Currently the repo is setup to deploy to a Rancher environment with the
configuration as described in [./rancher-config](./rancher-config). This will
connect the site to the MongoDB specified by `MONGODB_URL` and set the checking
of the websites based on the setting of `PA11Y_CRON`. A cron setting such as
`0 30 0 * * 3,5` will run the checks at 00:30 every Wednesday and Friday.

The default setting in the [Dockerfile](Dockerfile) is to start the site in
READONLY mode. In order to add websites to the list of those to be checked,
the more needs to be read/write. Removing the setting from the Dockerfile will
achieve this.
However, once the websites have been added it is advised to turn
READONLY back on. The importance of this will depend how the site is accessed.
For example, if it is available on the internet with no authentication, it is
critically important to ensure the application is READONLY. Failing to do this
risks anybody making changes to the sites that are being tested which could
become an expensive mistake.

By default, when this app runs a build on
[Travis CI](https://travis-ci.org/nhsuk/pa11y-dashboard) it will be deployed to
the Rancher environment. This will create environments for PRs and the master
branch using the standard naming conventions and retrieving the environment
variables from the Key Vault.
