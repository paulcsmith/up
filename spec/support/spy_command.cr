class SpyCommand < Up::Command
  property called_args : Array(String)?

  def names
    ["unused"]
  end

  def summary
    "Super sneaky spy command"
  end

  def call(@called_args)
  end

  def called_without_args? : Bool
    called? && called_args == [] of String
  end

  def called_with?(args : Array(String)) : Bool
    called? && called_args == args
  end

  private def called? : Bool
    !called_args.nil?
  end
end
