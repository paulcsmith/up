class Up::HelpCommand < Up::Command
  def names
    %w(-h --help help)
  end

  def summary
    "Show this help message"
  end

  def call(_args)
    Up::Utils.print <<-TEXT
    #{"Up v#{Up::VERSION} ".colorize}

    #{commands_list}
    TEXT
  end

  private def main_container
    Up::Settings.parse.main_container
  end

  def commands_list
    String.build do |list|
      sorted_commands.each do |command|
        names = command.human_readable_names

        print_command(names, command.summary, to: list)
      end
      print_command "<anything else>",
        "Run #{"<anything else>".colorize.underline} in the main container",
        to: list
    end
  end

  private def print_command(name : String, summary : String, to io) : Nil
    io << " "
    io << name.colorize.bold
    io << list_padding_for(name)
    io << " #{arrow}  ".colorize.dim
    io << summary
    io << "\n"
  end

  private def sorted_commands : Array(Up::Command)
    Up::Runner::COMMANDS.sort_by(&.human_readable_names)
  end

  def list_padding_for(names)
    " " * (longest_command_name - names.size + 2)
  end

  def longest_command_name
    Up::Runner::COMMANDS.map(&.human_readable_names.size).max
  end

  def arrow
    "▸"
  end
end
