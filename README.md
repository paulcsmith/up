# Up

Up makes it easier to start, build, and run Docker for local development.

* **Much shorter commands.** For example, `up node test` instead of
  `docker-compose up run --rm web node test`
* **Automatic image rebuilds.** When files your image depends on are changed
  (`package.json`, `Dockerfile`, etc.), Up will  rebuild the images before
  running commands. No more pulling from git and wondering why your project
  isn't working (oops, forgot to run `docker-compose build`).
* **Simple setup & installation**.

> Note that Up will not automatically rebuild containers that are running. You must
> stop them first. Then when you run any Up command it will rebuild the image.

## Installation

#### On macOS:

```bash
brew tap paulcsmith/up
brew install docker-up
```

#### On Linux:

1. Install [Crystal](https://crystal-lang.org/reference/installation/)
1. Clone and build Up:

```bash
git clone https://github.com/paulcsmith/up.git
cd up
git checkout v0.1.6
shards install
crystal build src/run.cr -o up
cp up /usr/local/bin
echo "\nAll done! Run 'up install' in a project using Docker to get started."
```

Once it is installed, you can remove the leftovers: `cd .. && rm -rf up`

## Basic usage

Before doing anything else, set up your project with Docker and Docker compose.

Once you've got your `Dockerfile` and `docker-compose.yml` set up:

1. Run `up install` to create an `up.yml` settings file in your project directory.
1. Check the [`up.yml` settings](#configuring-up). You'll probably want to
   add files that [Up can track to rebuild images automatically](#automatic-rebuilding)
   if they change.

Now you're ready to get running with Up! Take a look at the commands below
(or use `up help`).

## Commands

* `up` - starts your containers (e.g. `docker-compose up`). This will also build
  the container if not already built, and will
  [rebuild automatically](#automatic-rebuilding) if tracked files change.
* `up -d` - same as above but starts containers in the background.
* `up <any non-Up command>` - if there is no matching Up command, Up will run
  the command in the main app container (which is configured in `up.yml`). For example,
  `up bin/rake` would run `docker-compose run --rm app bin/rake`.
* `up run <args>` - run `<args>` using Docker compose. Similar to `docker-compose run --rm <args>`.
* `up stop` - stop any running containers. Similar to `docker-compose down`.
* `up ssh` - Run bash on the main container.
* `up install` - create an `up.yml` file. The `up.yml` file is where you can
  configure which files should trigger automatic rebuilds, what the main app container
  is, etc.
* `up compose <command>` - runs the docker compose command. Takes into account
  the `docker_compose_command` defined in `up.yml`, which is handy if your
  default compose configuration is a little more custom. Example `up compose logs`

## Configuring Up

Up can be configured using the `up.yml` file in your project. A default `up.yml`
is generated for you when you run `up install`.

#### `main_container`

`up <any command>` will default to running in this container. Defaults to `app`

For example, `up node test` will run `node index.js` in the `app` container.

#### `docker_compose_command`

You can customize the docker compose command here. Defaults to `docker-compose`.

Here's an example of how would tell up to use a different docker-compose file:

    docker_compose_command: docker-compose -f docker-compose.dev.yml

> Note: for most projects the default is fine.

#### `rebuild_when_changed`

Up automatically rebuilds images when you run a command and any of these
files have changed.

More details below.

## Automatic rebuilding

Up uses the files and paths in `rebuild_when_changed` in your `up.yml` to
determine when it should rebuild the containers.

By default Up tracks the common docker files and directories, but you will likely
want to watch other files your images depend on.

Below are some hints to get started.

### Crystal & Lucky

```yaml
rebuild_when_changed:
  # Add these in your up.yml
  - shard.*
  - db/*
  - webpack.mix.js
  - package.json
```

### Node

```yaml
rebuild_when_changed:
  # Add these in your up.yml
  - yarn.lock
  - package.json
  - npm-shrinkwrap.json
```

### Rails

```yaml
rebuild_when_changed:
  # Add these entries to up.yml
  - db/*
  - Gemfile
  - Gemfile.lock
```

## Contributing

1. Fork it (<https://github.com/paulcsmith/up/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Paul Smith](https://github.com/paulcsmith) - creator and maintainer
