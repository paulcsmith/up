require "teeplate"
require "./up/command"
require "./up/*"
require "./up/commands/*"

module Up
  def self.run(args : Array(String))
    Up::Runner.new(args).call
  end
end

Up.run(ARGV.dup)
