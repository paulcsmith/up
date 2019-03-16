abstract class Up::Command
  private getter args

  abstract def name : String | Array(String)
  abstract def call

  def initialize(@args : Array(String))
  end

  private def initialize
    @args = [] of String
  end

  def self.empty
    new
  end

  def self.call(args)
    new(args).call
  end

  def matches?(command_name : String) : Bool
    [name].flatten.includes?(command_name)
  end
end
