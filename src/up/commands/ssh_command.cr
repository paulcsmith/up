class Up::SshCommand < Up::Command
  def name
    "ssh"
  end

  def call(_args)
    Up::RebuildIfChanged.call
    Up::Utils.shell("docker-compose run --rm app bash")
  end
end
