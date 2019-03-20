class Up::StopCommand < Up::Command
  def name
    "stop"
  end

  def call
    Up::Utils.shell("docker-compose down")
  end
end
