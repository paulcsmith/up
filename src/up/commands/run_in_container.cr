class Up::RunInContainer < Up::Command
  def name
    "start"
  end

  def call(args)
    Up::RebuildIfChanged.call
    Up::Utils.docker_compose("run --rm #{args.join(" ")}")
  end
end