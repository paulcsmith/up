class Up::VersionCommand < Up::Command
  def name
    ["-v", "--version", "version"]
  end

  def call(_args)
    Up::Utils.print(Up::VERSION)
  end
end
