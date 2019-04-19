class Up::SshCommand < Up::Command
  def names
    ["ssh"]
  end

  def summary
    "Start the main container and run bash"
  end

  def call(_args)
    Up::RebuildIfChanged.call
    Up::Utils.docker_compose("run --rm #{Up::Settings.parse.main_container} bash")
  end
end
