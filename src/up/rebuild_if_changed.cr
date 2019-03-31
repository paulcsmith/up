class Up::RebuildIfChanged
  private getter tracked_files = Up::TrackedFiles.new

  def self.call
    new.call
  end

  def call
    if tracked_files.changed?
      rebuild
      tracked_files.save_cache
    end
  end

  private def rebuild
    Up::Utils.shell("docker-compose build")
  end
end
