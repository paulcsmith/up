class Up::StartContainers < Up::Command
  def name
    "start"
  end

  def call(_args)
    Up::RebuildIfChanged.call
    Up::Utils.docker_compose("up")
  end
end
