require "spec"
require "file_utils"
require "../src/up"
require "./setup/*"
require "./support/*"

Up::Utils.configure(&.raise_instead_of_exiting = true)
