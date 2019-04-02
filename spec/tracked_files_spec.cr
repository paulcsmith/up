require "./spec_helper"

describe Up::TrackedFiles do
  describe "#cached" do
    it "returns the locations and timestamps in the cache" do
      with_cache_location("./spec/fixtures/up.cache") do
        tracked_files = Up::TrackedFiles.new

        tracked_files.cached.should eq({
          "file1" => 123,
        })
      end
    end

    it "is empty if cache file does not exist" do
      with_cache_location("./does-not-exist.yml") do
        tracked_files = Up::TrackedFiles.new

        tracked_files.cached.should eq({} of String => Int64)
      end
    end
  end

  describe "#current" do
    it "returns a list of locations and timestamps" do
      with_settings_location("spec/fixtures/up.complete.yml") do
        tracked_files = Up::TrackedFiles.new
        currently_tracked_files = tracked_files.current

        currently_tracked_files.keys.should eq([
          "spec/fixtures/file1.txt",
          "spec/fixtures/file2.txt",
        ])
        currently_tracked_files.values.each(&.is_a?(Int64))
      end
    end
  end

  it "saves and caches stuff" do
    FileUtils.rm_rf("./spec/fixtures/up.fresh.cache")
    with_settings_location("spec/fixtures/up.complete.yml") do
      with_cache_location("./spec/fixtures/up.fresh.cache") do
        tracked_files = Up::TrackedFiles.new
        tracked_files.changed?.should be_true

        tracked_files.save_cache
        tracked_files.changed?.should be_false
      end
    end
  end
end

private def with_cache_location(location : String)
  Up.temp_config(cache_location: location) do
    yield
  end
end

private def with_settings_location(location : String)
  Up.temp_config(settings_location: location) do
    yield
  end
end
