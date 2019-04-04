class Up::StartContainersInBackground < Up::Command
  def name
    "-d"
  end

  def call(args)
    Up::StartContainersCommand.new.call(["-d"] + args)
  end
end
