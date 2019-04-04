class Up::SshCommand < Up::Command
  def name
    "ssh"
  end

  def call(_args)
    Up::RebuildIfChanged.call
    Up::Utils.docker_compose("run #{Up::Settings.parse.main_container} bash")
  end
end
