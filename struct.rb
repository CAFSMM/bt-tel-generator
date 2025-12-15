require 'json'
require 'date'

# Load all JSON files from the models directory
json_files = Dir[File.join(__dir__, 'models', '*.json')]

# List all loaded JSON files
puts "Loaded model JSON files:"
json_files.each do |file|
    puts "  - #{File.basename(file)}"
end
