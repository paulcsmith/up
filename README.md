# Up

Docker offers an incredible promise, but falls short for local development.

Up makes it easier to start, build, and run Docker locally.

## Basic usage

1. Set up your project with Docker and Docker compose.
1. Run `up install` to create an `up.yml` file.
1. Run `up` and Up will intelligently build containers if needed and then
   start your containers.
1 Run `up <any command>` to run commands in your main container. By default
  this is your app container, but can be configured in `up.yml`

> For example `up rails db:migrate`, `up phx.server`, or `up node index.js`

## Command Details

* `up` - starts your containers with `docker-compose up`. This will also build
  the container if not already built, and will rebuild automatically if required
  files change.
* `up install` - create an `up.yml` file. This is where you can configure which
  files should trigger rebuilds, what the main app container is, etc.
* `up stop` - stop any running containers.
* `up ssh` - start a bash shell in a container.
* `up nuke` - deletes volumes, images, and containers and start from scratch.
* `up <any command>` - any command non-Up command will be run in the main app
  container. The main container defaults to one called `app`, but can be
  configured in `up.yml`

## Configuring Up

```yml
# `up <any command>` will default to running in this container
main_container: app
# Running `up` will automatically rebuild the image if these conditions are met
rebuild_when:
  files_changed:
    - shard.yml
    - shard.lock
    - Dockerfile
    - docker/*
    - docker-compose.yml
    - package.json
# You can add additional compose commands here
docker_compose_command: docker-compose
# Add shortcuts for `up` commands`
shortcuts:
  # If you run `up spec` it will run `crystal spec` in the `app` container
  spec:
    container: app
    command: crystal spec
```

## Installation

1. Add the dependency to your `shard.yml`:

   ```yaml
   dependencies:
     up:
       github: your-github-user/up
   ```

2. Run `shards install`

## Usage

```crystal
require "up"
```

TODO: Write usage instructions here

## Development

TODO: Write development instructions here

## Contributing

1. Fork it (<https://github.com/your-github-user/up/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Paul Smith](https://github.com/your-github-user) - creator and maintainer
