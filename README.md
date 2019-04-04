# Up

Docker offers an incredible promise, but falls short for local development.

Up makes it easier to start, build, and run Docker locally.

* **Much shortens commands.** `up node test` instead of
  `docker-compose up run --rm web node test`
* **Automatic image rebuilds.** No more pulling from git and wondering why your
  project isn't working. Up will track necessary files and rebuild for you.
* **Simple setup & installation**.

## Installation on macOS

```
brew tap paulcsmith/up
brew install up
```

> Instructions for Linux coming soon.

## Basic usage

> This assumes you already have Dockerfile and docker-compose set up.

1. Run `up install` to create an `up.yml` file.
1. Run `up` and Up will intelligently build containers if needed and then
   start your containers. Similar to `docker-compose up --build`.
1 Run `up <any command>` to run commands in your main container (configurable
in `up.yml`). By default this is your `app` container.

> For example `up rails db:migrate`, `up phx.server`, or `up node index.js`

## Command Details

* `up` - starts your containers with `docker-compose up`. This will also build
  the container if not already built, and will rebuild automatically if required
  files change.
* `up install` - create an `up.yml` file. This is where you can configure which
  files should trigger rebuilds, what the main app container is, etc.
* `up stop` - stop any running containers.
* `up ssh` - start a bash shell in the main container.
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

## Set up which files to track

These are examples of files Up should track for rebuilding.

### Crystal/Lucky

```yaml
# up.yml
rebuild_when_changed:
  # Add these:
  - shard.*
  - db/*
  - script/setup
  # For Lucky projects
  - package.json
  - webpack.mix.js
```

### Ruby/Rails

```yaml
# up.yml
rebuild_when_changed:
  # Add these:
  - Gemfile
  - Gemfile.lock
  - db/*
  - bin/setup
```

### Elixir

```yaml
# up.yml
rebuild_when_changed:
  # Add these:
  - mix.*
  - priv/*
```

### Node

```yaml
# up.yml
rebuild_when_changed:
  # Add these:
  - package.json
  - package-lock.json
  - npm-shrinkwrap.json
  - yarn.lock
```

## Installation


## Releasing a new version

1. Run `script/build`
1. Run `script/release`

## Contributing

1. Fork it (<https://github.com/your-github-user/up/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Paul Smith](https://github.com/paulcsmith) - creator and maintainer
