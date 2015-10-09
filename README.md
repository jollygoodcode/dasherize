# Dasherize

[![Build Status](https://travis-ci.org/jollygoodcode/dasherize.svg?branch=master)](https://travis-ci.org/jollygoodcode/dasherize)

Dasherize is a beautiful material-based dashboard for your projects which provides you with an overview of open Pull Requests and Issues, and statuses of your CI, all on a single web page.

Currently supports GitHub, Travis, CodeShip and CircleCI.

Take it for a spin on [http://dasherize.com](http://dasherize.com). See [our blog](https://github.com/jollygoodcode/jollygoodcode.github.io/issues/5) for some technical details.

![screen shot 2015-09-30 at 11 12 13 pm](https://cloud.githubusercontent.com/assets/2112/10197301/712d75ce-67c9-11e5-8dca-563266c1a6ad.png)

## Origin

Dasherize was created as an alternative to [ProjectMonitor](https://github.com/pivotal/projectmonitor) and [Dashing](https://github.com/Shopify/dashing) because [@winstonyw](https://www.twitter.com/winstonyw) wanted a dashboard that displays GitHub Pull Requests and Issues count, and Continuous Integration status out of the box.

[@winstonyw](https://www.twitter.com/winstonyw) reviews Dasherize every morning over a cup of tea, to check on the CI status of projects and clear the backlog of PRs and Issues.

At the same time, a Presentation mode is made available for putting up Dasherize as a dashboard on a big screen monitor or TV, so that the projects' statuses are visible for all to see.

Please feel free to:

- Use Dasherize as a service on [http://dasherize.com](http://dasherize.com)
- Deploy a copy of Dasherize on Heroku

## Deploy on Heroku

[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy)

Once deployed on Heroku, you'll have to set up some ENV variables.

### ENV

`WWW_HOSTNAME` is your heroku app url (without scheme) for `config/application.rb`:

```
WWW_HOSTNAME=<dasherize-clone-name>.herokuapp.com
```

You will also need to register a GitHub OAuth application.

Go to [Applications](https://github.com/settings/applications/new) and
fill in the details:

- Application Name: Dasherize
- Homepage URL: `http://<your-app-name>.herokuapp.com`
- Authorization Callback URL: `http://<your-app-name>.herokuapp.com`

On the confirmation screen, copy the Client ID and Client Secret and set
`GITHUB_CLIENT_ID` and `GITHUB_CLIENT_SECRET`:

```
GITHUB_CLIENT_ID=<secret>
GITHUB_CLIENT_SECRET=<secret>
```

For performance, these are settings which you can use:

```
WEB_CONCURRENCY=2
WEB_MAX_THREADS=15
DB_POOL=15
DB_REAPING_FREQUENCY=10
RUBY_GC_HEAP_INIT_SLOTS=500000
RUBY_GC_HEAP_OLDOBJECT_LIMIT_FACTOR=0.9
```

## Wish List

- Production/Staging/Master commit SHA and how far apart are they?
- CI status of Pull Requests
- Health of PivotalTracker Project
- Bugs Count (when not using [RuntimeError.net](http://runtimeerror.net/))

## Contributing

Please see the [CONTRIBUTING.md](/CONTRIBUTING.md) file.

## Deployment

Please see the [DEPLOYMENT.md](/CONTRIBUTING.md) file.

## Credits

A huge THANK YOU to all our [contributors](https://github.com/jollygoodcode/dasherize/graphs/contributors)! :heart:

## License

Please see the [LICENSE.md](/LICENSE.md) file.

## Maintained by Jolly Good Code

[![Jolly Good Code](https://cloud.githubusercontent.com/assets/1000669/9362336/72f9c406-46d2-11e5-94de-5060e83fcf83.jpg)](http://www.jollygoodcode.com)

We specialise in Agile practices and Ruby, and we love contributing to open source.
[Speak to us](http://www.jollygoodcode.com/#get-in-touch) about your next big idea, or [check out our projects](http://www.jollygoodcode.com/open-source).
