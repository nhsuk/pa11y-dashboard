# Dockerized pa11y-dashboard

A Docker container that runs [pa11y-dashboard](https://github.com/pa11y/dashboard).

## Running locally

Build and run with [./scripts/start](./scripts/start). When the dashboard is
running it is available at [http://localhost:3333](http://localhost:3333).

## Running on a server

Currently the repo is setup to deploy to a Rancher environment with the
configuration as described in [./rancher-config](./rancher-config). This will
connect the dashboard to the MongoDB specified by `MONGODB_URL` and schedule
the automated checks for the websites to run according to the cron scheduled
specified by `PA11Y_CRON`.
A cron schedule such as `0 30 0 * * 3,5` will run the checks at 00:30 every
Wednesday and Friday.

## Adding websites to run checks against

By default the dashboard is run in `READONLY` mode. In order to add
websites to run checks against the dashboard needs to be editable. To do this
the dashboard should be started by setting `READONLY=flase`
e.g. `READONLY=false ./scripts/start`.

When the websites you want to run checks against have been added, it is
advisable to run the dashboard in `READONLY` mode.
How important this is depends on who has access. For example, if the dashboard
is available over the internet and has no authentication, anybody could make
changes. This can not only be annoying, it could become costly if your
infrastructure is running checks for websites you have no interest in.

## CI & Deployment

The dashboard is configured to have
[Travis CI](https://travis-ci.org/nhsuk/pa11y-dashboard) to run a build for
every PR and build of the `master` branch. If the initiator of the build is a
member of the NHS.UK GitHub organisation, a deployment will be made to the
NHS.UK Rancher environment.
The deployment is initiated from the [./scripts/deploy.sh](./scripts/deploy.sh)
script. The script will use the latest standards for naming and environment
variable retrieval.
