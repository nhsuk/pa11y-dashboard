# Dockerized pa11y-dashboard

A Docker container that runs [pa11y-dashboard](https://github.com/pa11y/dashboard).

## Running in Development

Build and run with `./scripts/start`. When running the dashboard will be
available at `http://localhost:3333`.
In order to run in `READ/WRITE` mode run `READONLY=false ./scripts/start`.

## Running on a server

Currently the repo is setup to deploy to a Rancher environment with the
configuration as described in [./rancher-config](./rancher-config). This will
connect the site to the MongoDB specified by `MONGODB_URL` and schedule the
automated checks of the websites to run according to the setting of
`PA11Y_CRON`.
A cron setting such as `0 30 0 * * 3,5` will run the checks at 00:30 every
Wednesday and Friday.

The default settings in the [Dockerfile](Dockerfile) start the site in
`READONLY` mode. In order to add websites to the list of those to be checked,
the website needs to be in `READ/WRITE` mode. This is achieved by setting
`READONLY=false`, as specified [above](./#running-in-development).

When the websites have been added, it is advisable to ensure the website is
`READONLY`. How important this is depends on who has access to the site.
For example, if the site is available over the internet and has no
authentication, anybody could make changes to the site.
This can not only be annoying, it could be a costly mistake if your
infrastructure is running checks on for websites you have no interest in.

## CI & Deployment

The application is configured for 
[Travis CI](https://travis-ci.org/nhsuk/pa11y-dashboard) to run builds for each
PR and build of the `master` branch. When this happens, if the initiator is a
member of the NHS.UK GitHub organisation, a deployment will be made to the
NHS.UK Rancher environment.
The deployment is initiated from the [./scripts/deploy](./scripts/deploy)
script and will use the standard naming conventions and mechanisms of
retrieving environment variables.
