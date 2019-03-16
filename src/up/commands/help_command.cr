class Up::HelpCommand < Up::Command
  def name
    %w(-h --help help)
  end

  def call
    puts "Help!!"
  end
end
