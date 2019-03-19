class Up::Runner
  COMMANDS = [
    Up::HelpCommand,
    Up::InstallCommand,
  ]
  VERSION = "0.1.0"

  @command_name : String?
  @args : Array(String)

  private getter args

  def initialize(@args : Array(String))
    @command_name = @args.shift?
  end

  def self.call(*args, **named_args)
    new(*args, **named_args).run
  end

  def call
    if command_name.nil?
      docker_compose_up
    elsif (command = up_command)
      command.call(args)
    else
      run_command_in_main_container
    end
  end

  private def docker_compose_up
    # TODO
  end

  private def run_command_in_main_container
    # Combine command name and args since we want to pass the args as-is
    # to the container

    # TODO
    # RunCommandInMainContainer.call(command_name + args)
  end

  private def up_command
    command_name.try do |name|
      COMMANDS.find { |command| command.empty.matches?(name) }
    end
  end

  def command_name : String?
    if @command_name.try(&.empty?)
      nil
    else
      @command_name
    end
  end
end
