struct CommandCalledWithExpectation
  private getter args

  def initialize(@args : Array(String))
  end

  def match(command : SpyCommand) : Bool
    command.called_with?(args)
  end

  def failure_message(command : SpyCommand) : String
    <<-TEXT
    Expected command to be called with args:

        #{args}

    Instead got:

        #{command.called_args}
    TEXT
  end

  def negative_failure_message(command : SpyCommand)
    <<-TEXT
    Expected NOT to be called with args:

        #{args}

    But it was...
    TEXT
  end
end

def have_been_called_with?(args : Array(String))
  CommandCalledWithExpectation.new(args)
end
