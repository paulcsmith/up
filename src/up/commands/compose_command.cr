class Up::ComposeCommand < Up::Command
  def names
    ["compose"]
  end

  def summary
    "Run a command with 'docker_compose_command' from up.yml"
  end

  def call(args)
    Up::RebuildIfChanged.call
    Up::Utils.docker_compose(args.join(" "))
  end
end
