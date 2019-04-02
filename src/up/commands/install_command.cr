class Up::InstallCommand < Up::Command
  def name
    "install"
  end

  def call(_args)
    if already_installed?
      print_already_installed_message
    else
      install
    end
  end

  private def already_installed?
    File.exists?(Up.settings.settings_location)
  end

  private def print_already_installed_message
    puts "#{"Did nothing.".colorize.bold.yellow} It looks like Up is already installed."
  end

  private def install
    UpInstallationTemplate.new.render("./")
    ignore_cache_files
    print_success_message
  end

  private def ignore_cache_files
    if File.exists?(".gitignore") && !already_ignoring_up_cache?
      command = "echo '\n# Ignore Up cache file\nup.cache' >> .gitignore"
      Up::Utils.shell(command)
    end
  end

  private def already_ignoring_up_cache? : Bool
    File.read(".gitignore").includes?("up.cache")
  end

  private def print_success_message
    puts <<-TEXT
    Installed Up in #{Up.settings.settings_location.colorize.bold.green}
    TEXT
  end
end
