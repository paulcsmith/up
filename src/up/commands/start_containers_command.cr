class Up::StartContainersCommand < Up::Command
  def names
    ["start"]
  end

  def summary
    "Alias for running just 'up'. Similar to 'docker-compose up'"
  end

  def call(args)
    Up::RebuildIfChanged.call
    Up::Utils.docker_compose("up #{args.join(" ")}")
  end
end
