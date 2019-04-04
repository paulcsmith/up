class Up::StartContainersInBackground < Up::Command
  def names
    ["-d"]
  end

  def summary
    "Start containers in the background"
  end

  def call(args)
    Up::StartContainersCommand.new.call(["-d"] + args)
  end
end
