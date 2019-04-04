require "./exit_error"

module Up::Utils
  Habitat.create do
    # Used in tests
    setting raise_instead_of_exiting : Bool = false
  end

  def self.shell(command)
    Process.run(
      command,
      shell: true,
      output: Up.settings.output_io,
      error: STDERR
    )
  end

  def self.print(message)
    Up.settings.output_io.puts(message)
  end

  def self.exit_with_message(message : String) : Nil
    if settings.raise_instead_of_exiting
      raise Up::ExitError.new(message)
    else
      self.print(message)
      exit 1
    end
  end

  def self.docker_compose(command : String) : Nil
    compose_command = "#{Up::Settings.parse.docker_compose_command} #{command}"
    Up.settings.output_io.puts compose_command.colorize.dim
    shell(compose_command)
  end
end
