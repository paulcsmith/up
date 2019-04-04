class Up::Runner
  COMMANDS = [
    Up::HelpCommand.new,
    Up::InstallCommand.new,
    Up::SshCommand.new,
    Up::StopCommand.new,
    Up::StartContainers.new,
    Up::VersionCommand.new,
  ]

  Habitat.create do
  end

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
      Up.settings.start_container_command.call([] of String)
    elsif (command = up_command)
      command.call(args)
    else
      run_command_in_main_container
    end
  end

  private def run_command_in_main_container
    main_container = "app"
    full_command = args.push(main_container).push(command_name.not_nil!)
    Up.settings.run_in_container_command.call(full_command)
  end

  private def up_command : Up::Command?
    command_name.try do |name|
      COMMANDS.find { |command| command.matches?(name) }
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
