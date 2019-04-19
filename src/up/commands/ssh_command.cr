class Up::SshCommand < Up::Command
  def names
    ["ssh"]
  end

  def summary
    "Start the container and run bash"
  end

  def call(args)
    Up::RebuildIfChanged.call
    Up::Utils.docker_compose("run --rm #{container_name(args)} bash")
  end

  private def container_name(args) : String
    case args.size
    when 1
      args.first
    when 0
      Up::Settings.parse.main_container
    else
      Up::Utils.exit_with_message("The 'ssh' command expected just one argument (the container name)")
    end
  end
end
