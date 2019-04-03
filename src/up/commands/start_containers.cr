class Up::StartContainers < Up::Command
  def name
    "start"
  end

  def call(args)
    Up::RebuildIfChanged.call
    Up::Utils.docker_compose("up #{args.join(" ")}")
  end
end
