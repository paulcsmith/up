class Up::InstallCommand < Up::Command
  def name
    "install"
  end

  def call
    if already_installed?
      print_already_installed_message
    else
      install
    end
  end

  private def already_installed?
    File.exists?("./up.yml")
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
      command = "echo 'up.cache' >> .gitignore"
      Up::Utils.shell(command)
    end
  end

  private def already_ignoring_up_cache? : Bool
    !File.read(".gitignore").includes?("up.cache")
  end

  private def print_success_message
    puts <<-TEXT
    Installed in #{"./up.yml".colorize.bold.green}
    TEXT
  end
end
