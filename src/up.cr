require "teeplate"
require "colorize"
require "habitat"
require "yaml"
require "./up/command"
require "./up/*"
require "./up/commands/*"

module Up
  VERSION = "0.1.0"

  Habitat.create do
    # Using Habitat so we can swap things out in specs
    setting output_io : IO = STDOUT
    setting start_container_command : Up::Command = Up::StartContainers.new
    setting run_in_container_command : Up::Command = Up::RunInContainer.new
    setting cache_location : String = "up.cache"
    setting settings_location : String = "up.yml"
  end

  def self.run(args : Array(String))
    Up::Runner.new(args).call
  end
end
