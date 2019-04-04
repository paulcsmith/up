# Up

Docker offers an incredible promise, but falls short for local development.

Up makes it easier to start, build, and run Docker locally.

* **Much shortens commands.** `up node test` instead of
  `docker-compose up run --rm web node test`
* **Automatic image rebuilds.** No more pulling from git and wondering why your
  project isn't working. Up will track necessary files and rebuild for you.
* **Simple setup & installation**.

## Installation

On macOS:

```bash
brew tap paulcsmith/up
brew install docker-up
```

> Linux instructions coming soon.

## Basic usage

1. Set up your project with Docker and Docker compose.
1. Run `up install` to create an `up.yml` file for your project.
1. Now you can run `up` and Up will intelligently build containers if needed and then
   start your containers.
1. Run `up <any command>` to run commands in your main container. By default
   this is your `app` container defined in `docker-compose.yml`, but it can be changed in `up.yml`

> For example `up bundle exec rspec`, `up mix test`, or `up node test`

## Command Details

* `up` - starts your containers with `docker-compose up`. This will also build
  the container if not already built, and will rebuild automatically if required
  files change.
* `up -d` - same as above but starts in the background.
* `up install` - create an `up.yml` file. This is where you can configure which
  files should trigger rebuilds, what the main app container is, etc.
* `up stop` - stop any running containers.
* `up ssh` - start a bash shell in the main container.
* `up compose <command>` - runs the docker compose command. A short cut for using `docker-compose`. Also takes into account 
  the `docker_compose_command` defined in `up.yml`, which is handy if your default compose configuration is a little more 
  custom.
* `up <any command>` - any non-Up command will be run in the main app
  container. The main container defaults to one called `app`, but can be
  configured in `up.yml`

## Configuring Up

```yml
# `up <any command>` will default to running in this container
main_container: app
# Running `up` will automatically rebuild the image if these conditions are met
rebuild_when_changed:
  - shard.yml
  - shard.lock
  - Dockerfile
  - docker/*
  - docker-compose.yml
  - package.json
# You can add additional compose commands here
docker_compose_command: docker-compose
```

## Development

TODO: Write development instructions here

## Contributing

1. Fork it (<https://github.com/paulcsmith/up/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Paul Smith](https://github.com/paulcsmith) - creator and maintainer
