class Up::HelpCommand < Up::Command
  def name
    %w(-h --help help)
  end

  def call(_args)
    Up::Utils.print "See the README at https://github.com/paulcsmith/up/blob/master/README.md"
  end
end
