require 'json'
require 'date'

# # Load all JSON files from the models directory
# json_files = Dir[File.join(__dir__, 'models', '*.json')]

# # List all loaded JSON files
# puts "Loaded model JSON files:"
# json_files.each do |file|
#     puts "  - #{File.basename(file)}"
# end

def load_model (mode_type)
    file_path = File.join(__dir__, 'models', "#{mode_type}.json")
    if File.exist?(file_path)
        file = File.open(file_path, "r")
        model_data = JSON.parse(file.read)
        file.close
        return model_data
    else
        puts "Model file #{mode_type}.json not found."
        return nil
    end  
end
