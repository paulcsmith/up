class Up::RunInContainer < Up::Command
  def names
    ["run"]
  end

  def summary
    "Run a command using docker compose"
  end

  def call(args)
    Up::RebuildIfChanged.call
    Up::Utils.docker_compose("run --rm #{args.join(" ")}")
  end
end
