Up.configure do |settings|
  settings.output_io = IO::Memory.new
end

Spec.before_each { reset_output }

private def reset_output
  Up.settings.output_io.close
  Up.configure(&.output_io = IO::Memory.new)
end
