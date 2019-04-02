class Up::StopCommand < Up::Command
  def name
    "stop"
  end

  def call(_args)
    Up::Utils.docker_compose("down")
  end
end
