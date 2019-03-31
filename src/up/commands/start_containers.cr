class Up::StartContainers < Up::Command
  def name
    "start"
  end

  def call(_args)
    Up::RebuildIfChanged.call
    Up::Utils.shell("docker-compose up")
  end
end
