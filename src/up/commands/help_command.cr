class Up::HelpCommand < Up::Command
  def name
    %w(-h --help help)
  end

  def call(_args)
    Up::Utils.print "Help!!"
  end
end
