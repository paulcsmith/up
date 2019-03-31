class Up::Settings
  FILENAME = "up.yml"
  private getter yaml

  def initialize
    ensure_settings_exist!
    settings_yaml = File.read(FILENAME)
    @yaml = YAML.parse(settings_yaml)
  end

  private def ensure_settings_exist! : Nil
    if !File.readable?(FILENAME)
      puts "Settings file #{FILENAME} does not exist. Install up with 'up install'"
      exit 1
    end
  end

  def main_container : String
    yaml["main_container"]?.try(&.as_s) || "app"
  end

  def docker_compose_command : String
    yaml["docker_compose_command"]?.try(&.as_s) || "docker-compose"
  end

  def file_paths_to_track : Array(String)
    yaml["rebuild_when_changed"]?.try(&.as_a.map(&.as_s)) || [] of String
  end
end
