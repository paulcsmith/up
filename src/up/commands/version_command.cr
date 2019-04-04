class Up::VersionCommand < Up::Command
  def names
    %w(-v --version version)
  end

  def summary
    "Display the version of Up"
  end

  def call(_args)
    Up::Utils.print(Up::VERSION)
  end
end
