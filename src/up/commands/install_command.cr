class Up::InstallCommand < Up::Command
  def name
    "install"
  end

  def call
    if already_installed?
      puts "It looks like Up is already installed."
    else
      install
    end
  end

  private def already_installed?
    File.exists?("./up.yml")
  end

  private def install
    UpInstallationTemplate.new.render("./")
    ignore_cache_files
    print_success_message
  end

  private def ignore_cache_files
    command = "echo 'up.cache' >> .gitignore"
    Up::Utils.shell(command)
  end

  private def print_success_message
    puts <<-TEXT
    Installed Up! View/change settings in 'up.yml'
    TEXT
  end
end