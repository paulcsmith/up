module Up::Utils
  def self.shell(command)
    Process.run(
      command,
      shell: true,
      output: STDOUT,
      error: STDERR
    )
  end
end
