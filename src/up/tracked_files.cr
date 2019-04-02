class Up::TrackedFiles
  alias FilesAndTimestamps = Hash(String, Int64)
  delegate cache_location, to: Up.settings
  private getter settings = Up::Settings.parse

  def changed? : Bool
    cached != current
  end

  def cached : FilesAndTimestamps
    if has_cached_tracked_files?
      parse_cached_tracked_files
    else
      {} of String => Int64
    end
  end

  private def has_cached_tracked_files? : Bool
    File.readable?(cache_location)
  end

  private def parse_cached_tracked_files : FilesAndTimestamps
    parsed = YAML.parse File.read(cache_location)
    parsed.as_h.transform_keys(&.as_s).transform_values(&.as_i64)
  end

  def current : FilesAndTimestamps
    files_and_timestamps = {} of String => Int64

    Dir.glob(settings.tracked_file_locations).each do |file|
      files_and_timestamps[file] = timestamp(file)
    end

    files_and_timestamps
  end

  def save_cache : Nil
    File.write(cache_location, current.to_yaml)
  end

  private def timestamp(file : String) : Int64
    File.info(file).modification_time.to_s("%Y%m%d%H%M%S").to_i64
  end
end
