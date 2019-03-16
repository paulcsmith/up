class Up::NewCommand < Up::Command
  def name
    "new"
  end

  def call
    if already_installed?
      puts "It looks like Up is already installed."
    else
      install
      puts <<-TEXT
      Installed Up! View/change settings in 'up.yml'
      TEXT
    end
  end

  private def already_installed?
    File.exists?("./up.yml")
  end

  private def install
    UpInstallationTemplate.new.render("./")
    ignore_up_cache_files
  end

  private def ignore_up_cache_files
    command = "echo 'up.cache' >> .gitignore"
    Up::Utils.shell(command)
  end
end
