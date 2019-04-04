abstract class Up::Command
  alias CommandArgs = Array(String)

  abstract def names : Array(String)
  abstract def call(args : CommandArgs)
  abstract def summary : String

  def human_readable_names : String
    names.join(", ")
  end

  def matches?(command_name : String) : Bool
    names.includes?(command_name)
  end
end
