class Up::TrackedFiles
  CACHE_FILENAME = "up.cache"

  alias FilesAndTimestamps = Hash(String, Int64)
  private getter settings = Up::Settings.new

  def changed? : Bool
    cached_tracked_files != current_tracked_files
  end

  def cached_tracked_files : FilesAndTimestamps
    if has_cached_tracked_files?
      parse_cached_tracked_files
    else
      {} of String => Int64
    end
  end

  private def has_cached_tracked_files? : Bool
    File.readable?(CACHE_FILENAME)
  end

  private def parse_cached_tracked_files : FilesAndTimestamps
    parsed = YAML.parse File.read(CACHE_FILENAME)
    parsed.as_h.transform_keys(&.as_s).transform_values(&.as_i64)
  end

  def current_tracked_files : FilesAndTimestamps
    files_and_timestamps = {} of String => Int64

    Dir.glob(settings.file_paths_to_track).each do |file|
      files_and_timestamps[file] = timestamp(file)
    end

    files_and_timestamps
  end

  def save_cache : Nil
    File.write(CACHE_FILENAME, current_tracked_files.to_yaml)
  end

  private def timestamp(file : String) : Int64
    File.info(file).modification_time.to_s("%Y%m%d%H%M%S").to_i64
  end
end
