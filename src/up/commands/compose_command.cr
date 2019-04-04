class Up::ComposeCommand < Up::Command
  def name
    "compose"
  end

  def call(args)
    Up::RebuildIfChanged.call
    Up::Utils.docker_compose(args.join(" "))
  end
end
