require "./spec_helper"

describe Up::Settings do
  it "parses settings" do
    with_settings_location("spec/fixtures/up.complete.yml") do
      settings = Up::Settings.parse

      settings.main_container.should eq("custom-main-container")
      settings.docker_compose_command.should eq("docker-compose-custom")
      settings.tracked_file_locations.should eq([
        "spec/fixtures/file1.txt",
        "spec/fixtures/file2.txt",
      ])
    end
  end

  it "sets defaults" do
    with_settings_location("spec/fixtures/up.blank.yml") do
      settings = Up::Settings.parse

      settings.main_container.should eq("app")
      settings.docker_compose_command.should eq("docker-compose")
      settings.tracked_file_locations.should eq([] of String)
    end
  end

  it "exits with helpful message if settings file not found" do
    with_settings_location("does_not_exist.yml") do
      expect_to_exit_with_message("does not exist") do
        Up::Settings.parse
      end
    end
  end
end

private def expect_to_exit_with_message(message)
  expect_raises(Up::ExitError, "does not exist") do
    yield
  end
end

private def with_settings_location(location : String)
  Up.temp_config(settings_location: location) do
    yield
  end
end
