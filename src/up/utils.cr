module Up::Utils
  def self.shell(command)
    Process.run(
      command,
      shell: true,
      output: STDOUT,
      error: STDERR
    )
  end

  def self.print(message)
    Up.settings.output_io.puts(message)
  end
end
