require "./spec_helper"

describe Up do
  it "runs the command if one matches the first argument" do
    Up.run(["help", "ignored"])

    Up.settings.output_io.to_s.should contain("See the README")
  end

  it "starts the containers if no args given" do
    fake_start_command = SpyCommand.new

    Up.temp_config(start_container_command: fake_start_command) do
      Up.run([] of String)
    end

    fake_start_command.called_without_args?.should be_true
  end

  it "runs the command in the main container if args don't match any command" do
    fake_run_command = SpyCommand.new
    args = ["run", "me", "please"]

    Up.temp_config(run_in_container_command: fake_run_command) do
      Up.run(args)
    end

    fake_run_command.called_with?(args).should be_true
  end
end
