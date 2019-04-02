class Up::Settings
  YAML.mapping(
    main_container: {
      type:    String,
      default: "app",
    },
    docker_compose_command: {
      type:    String,
      default: "docker-compose",
    },
    tracked_file_locations: {
      type:    Array(String),
      key:     "rebuild_when_changed",
      default: [] of String,
    }
  )

  def self.parse : Up::Settings
    ensure_settings_exist!
    settings_yaml = File.read(location)
    from_yaml(settings_yaml)
  end

  private def self.ensure_settings_exist! : Nil
    if !File.readable?(location)
      Up::Utils.exit_with_message \
        "Settings file #{location} does not exist. Install up with 'up install'"
    end
  end

  private def self.location
    Up.settings.settings_location
  end
end
