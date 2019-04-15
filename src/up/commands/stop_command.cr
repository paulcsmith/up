class Up::StopCommand < Up::Command
  def names
    ["stop", "down"]
  end

  def summary
    "Bring down all containers"
  end

  def call(_args)
    Up::Utils.docker_compose("down")
  end
end
