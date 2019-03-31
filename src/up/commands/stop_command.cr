class Up::StopCommand < Up::Command
  def name
    "stop"
  end

  def call(_args)
    Up::Utils.shell("docker-compose down")
  end
end
