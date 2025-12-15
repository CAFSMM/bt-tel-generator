require 'json'
require 'date'

$zone_data_model = nil

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

def set_model (model_type)
    $zone_data_model = load_model(model_type)
end
