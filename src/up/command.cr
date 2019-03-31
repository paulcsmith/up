abstract class Up::Command
  alias CommandArgs = Array(String)

  abstract def name : String | Array(String)
  abstract def call(args : CommandArgs)

  def matches?(command_name : String) : Bool
    [name].flatten.includes?(command_name)
  end
end
