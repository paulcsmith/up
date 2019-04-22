class Up::RunInContainer < Up::Command
  def names
    ["run"]
  end

  def summary
    "Run a command using docker compose"
  end

  def call(args)
    #     project_name=$(basename "$(pwd | tr -d '_ -')")
    # image_name=${project_name}_${service}_1
    # docker inspect -f {{.State.Running}} image name

    # docker-compose ps
    #
    # Check that all are up (not have "Exit")

    # If so, use `exec` instead of `run --rm`
    Up::RebuildIfChanged.call
    Up::Utils.docker_compose("run --rm #{args.join(" ")}")
  end
end
