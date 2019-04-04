class Up::Runner
  COMMANDS = [
    Up::HelpCommand.new,
    Up::InstallCommand.new,
    Up::SshCommand.new,
    Up::StopCommand.new,
    Up::StartContainersCommand.new,
    Up::StartContainersInBackground.new,
    Up::ComposeCommand.new,
    Up::VersionCommand.new,
  ]

  @args : Array(String)

  private getter args
  delegate main_container, to: Up::Settings.parse

  def initialize(@args : Array(String))
  end

  def self.call(*args, **named_args)
    new(*args, **named_args).run
  end

  def call
    if command_name.nil?
      Up.settings.start_container_command.call([] of String)
    elsif (command = up_command)
      command.call(args_without_command_name)
    else
      run_command_in_main_container
    end
  end

  private def args_without_command_name : Array(String)
    args.skip(1)
  end

  private def run_command_in_main_container
    Up.settings.run_in_container_command.call \
      [Up::Settings.parse.main_container] + args
  end

  private def up_command : Up::Command?
    command_name.try do |name|
      COMMANDS.find { |command| command.matches?(name) }
    end
  end

  def command_name : String?
    if @args.first?.try(&.empty?)
      nil
    else
      @args.first?
    end
  end
end
